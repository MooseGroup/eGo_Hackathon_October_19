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

import * as egoose from '@egodigital/egoose';
import * as mongoose from 'mongoose';


export const SCHEMA: mongoose.SchemaDefinition = {
    event: {
        lowercase: true,
        trim: true,
        type: String,
    },
    from: {
        type: Date,
    },
    status: {
        lowercase: true,
        trim: true,
        type: String,
    },
    time: {
        default: () => egoose.utc()
            .toDate(),
        type: Date,
    },
    until: {
        type: Date,
    },
    displayName: {
        lowercase: false,
        trim: true,
        type: String,
    },
    city: {
        lowercase: false,
        trim: true,
        type: String,
    },
    cityLat: {
        type: Number,
    },
    cityLng: {
        type: Number,
    },
    seatsAvailable: {
        type: Number,
    },
    seatsTotal: {
        type: Number,
    },
    vehicle_id: {
        lowercase: true,
        trim: true,
        type: String,
    },
};

export function setupSchema(schema: mongoose.Schema, name: string) {
    schema.index({ event: 1 });
    schema.index({ displayName: 1 });
    schema.index({ city: 1 });
    schema.index({ cityLat: 1 });
    schema.index({ cityLng: 1 });
    schema.index({ seatsAvailable: 1 });
    schema.index({ seatsTotal: 1 });
    schema.index({ status: 1 });
    schema.index({ vehicle_id: 1, event: 1 });
    schema.index({ vehicle_id: 1, event: 1, status: 1 });
    schema.index({ vehicle_id: 1, status: 1 });
    schema.index({ vehicle_id: 1 });
}
