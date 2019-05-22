/**
 * This file is part of the vehicle-api distribution (https://github.com/egodigital/hackathon/vehicle-api).
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
import * as express from 'express';
import * as path from 'path';
import { ControllerBase } from '../_share';


/**
 * Controller for '/app' routes.
 */
export class Controller extends ControllerBase {
    /** @inheritdoc */
    public __init() {
        if (egoose.IS_LOCAL_DEV) {
            this.__app.use('/app',
                express.static(path.join(__dirname, 'app')));
        } else {
            this.__app.use('/app',
                express.static(path.join(__dirname, '../../../webapp/dist')));
        }
    }
}
