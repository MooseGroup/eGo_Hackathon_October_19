/**
 * This file is part of the vehicle-booking-api distribution (https://github.com/egodigital/hackathon/api).
 * Copyright (c) e.GO Digital GmbH, Aachen, Germany
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import * as database from '../../../../../../../database';
import * as egoose from '@egodigital/egoose';
import { PATCH, Swagger } from '@egodigital/express-controllers';
import { APIv2VehicleBookingControllerBase, ApiV2VehicleBookingRequest, ApiV2VehicleBookingResponse } from './_share';
import { HttpResult } from '../../../../../../_share';


/**
 * Controller for /api/v2/vehicles/:vehicle_id/bookings/:booking_id/finish endpoints.
 */
export class Controller extends APIv2VehicleBookingControllerBase {
    /**
     * [PATCH]  /
     */
    @PATCH('/')
    @Swagger({
        "summary": "Finishes a booking.",
        "responses": {
            "200": {
                "schema": {
                    "$ref": "#/definitions/VehicleBookingItem"
                }
            },
            "400": {
                "schema": {
                    "$ref": "#/definitions/ErrorResponse"
                }
            },
        },
    })
    public finish_vehicle_booking(req: ApiV2VehicleBookingRequest, res: ApiV2VehicleBookingResponse) {
        return this.__app.withDatabase(async db => {
            const VEHICLE_ID = egoose.normalizeString(req.params['vehicle_id']);

            const VEHICLE_DOC = await db.Vehicles
                .findOne({
                    '_id': VEHICLE_ID,
                    'team_id': req.team.id,
                }).exec();

            if (VEHICLE_DOC) {
                const BOOKING_ID = egoose.normalizeString(req.params['booking_id']);

                const BOOKING_FILTER: any = {
                    '$and': [{
                        'id': BOOKING_ID,
                    }, {
                        'vehicle_id': VEHICLE_DOC.id,
                    }],
                };

                let bookingDoc = await db.VehicleBookings
                    .findOne(BOOKING_FILTER)
                    .exec();

                if (bookingDoc) {
                    if ('active' === egoose.normalizeString(bookingDoc.status)) {
                        await db.VehicleBookings
                            .updateOne({
                                '_id': bookingDoc._id,
                            }, {
                                'status': 'finished',
                            })
                            .exec();

                        await this._logBooking(
                            db, req, bookingDoc,
                            {
                                'status': 'finished',
                            }
                        );

                        bookingDoc = await db.VehicleBookings
                            .findOne(BOOKING_FILTER)
                            .exec();

                        return await database.vehicleBookingToJSON(
                            bookingDoc, db
                        );
                    }

                    return HttpResult.BadRequest((req: ApiV2VehicleBookingRequest, res: ApiV2VehicleBookingResponse) => {
                        return res.json({
                            success: false,
                            data: `Booking status is '${bookingDoc.status}' and must be one of the following values: 'active'`,
                        });
                    });
                }
            }

            return HttpResult.NotFound((req: ApiV2VehicleBookingRequest, res: ApiV2VehicleBookingResponse) => {
                return res.json({
                    success: false,
                    data: `Vehicle '${VEHICLE_ID}' not found!`,
                });
            });
        });
    }
}