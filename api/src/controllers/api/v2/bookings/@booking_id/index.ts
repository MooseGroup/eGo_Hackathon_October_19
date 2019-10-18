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

import * as database from '../../../../../database';
import * as egoose from '@egodigital/egoose';
import * as joi from 'joi';
import { DELETE, Swagger, PATCH } from '@egodigital/express-controllers';
import { APIv2VehicleBookingControllerBase, ApiV2VehicleBookingRequest, ApiV2VehicleBookingResponse } from './_share';
import { HttpResult } from '../../../../_share';

const SCHEMA_UPDATE_BOOKING = joi.object({
    'seatsAvailable': joi.number().required(),
});

/**
 * Controller for /api/v2/vehicles/bookings/:booking_id endpoints.
 */
export class Controller extends APIv2VehicleBookingControllerBase {
    /**
     * [DELETE]  /
     */
    @DELETE('/')
    @Swagger({
        "summary": "Deletes a vehicle booking.",
        "parameters": [{
            "in": "path",
            "name": "booking_id",
            "description": "The ID of the booking.",
            "required": true,
            "example": "5d9c5d82734cb701240245d8",
            "type": "string"
        }],
        "responses": {
            "200": {
                "schema": {
                    "$ref": "#/definitions/VehicleBookingItem"
                }
            },
            "404": {
                "schema": {
                    "$ref": "#/definitions/ErrorResponse"
                }
            },
        },
    })
    public delete_vehicle_booking(req: ApiV2VehicleBookingRequest, res: ApiV2VehicleBookingResponse) {
        return this.__app.withDatabase(async db => {
            const NOT_FOUND = () => {
                return HttpResult.BadRequest((req: ApiV2VehicleBookingRequest, res: ApiV2VehicleBookingResponse) => {
                    return res.json({
                        success: false,
                        data: `Booking '${req.booking.id}' not found!`,
                    });
                });
            };

            const BOOKING_DOC = await db.VehicleBookings
                .findById(req.booking.id)
                .exec();

            if (BOOKING_DOC) {
                await db.VehicleBookings
                    .remove({
                        '_id': BOOKING_DOC._id,
                    })
                    .exec();

                return await database.vehicleBookingToJSON(BOOKING_DOC, db);
            }

            return NOT_FOUND();
        });
    }

    /**
     * [PATCH]  /
     */
    @PATCH('/', SCHEMA_UPDATE_BOOKING)
    @Swagger({
        "summary": "Updates a booking.",
        "parameters": [{
            "in": "path",
            "name": "booking_id",
            "description": "The ID of the booking (only seats available).",
            "required": true,
            "example": "5d9c5d82734cb701240245d8",
            "type": "string"
        }],
        "responses": {
            "200": {
                "schema": {
                    "$ref": "#/definitions/VehicleBookingItem"
                }
            },
            "404": {
                "schema": {
                    "$ref": "#/definitions/ErrorResponse"
                }
            },
        },
    })
    public update_vehicle_booking(req: ApiV2VehicleBookingRequest, res: ApiV2VehicleBookingResponse) {
        const NEW_DATA: any = {
            'last_update': egoose.utc().toISOString(),
        };
        const NEW_SEATS = req.body.seatsAvailable;
        NEW_DATA['seatsAvailable'] = NEW_SEATS;
        return this.__app.withDatabase(async (db) => {
            await db.VehicleBookings.updateOne({
                '_id': req.booking.id,
            }, NEW_DATA).exec();

            const NEW_DOC = await db.VehicleBookings
                .findById(req.booking.id)
                .exec();
            return await database.vehicleBookingToJSON(NEW_DOC, db);
        });
    }
}
