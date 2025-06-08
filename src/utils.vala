/*
 * Copyright (C) 2025 Vladimir Vaskov <rirusha@altlinux.org>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see
 * <https://www.gnu.org/licenses/gpl-3.0-standalone.html>.
 * 
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Manager {
    public const int DBUS_TIMEOUT = 600000;

    public const string ALT_SISYPHUS_IMAGE = "registry.altlinux.org/alt/base:sisyphus";

    public errordomain AError {
        UNKNOWN,
        INTERNAL,
        FAILED,
        IO;

        public static AError from_dbus_error (DBusError e) {
            string[] parts = e.message.replace ("GDBus.Error:org.freedesktop.DBus.Error.", "").split (":");
            string name = parts[0];
            string message = parts[1];

            switch (name) {
                case "InvalidArgs":
                case "NoSuchObject":
                case "UnknownMethod":
                case "UnknownInterface":
                    error (message);
                case "Failed":
                    return new AError.FAILED (message);
                default:
                    return new AError.UNKNOWN (message);
            }
        }

        public static AError get_base_internal () {
            return new AError.INTERNAL (_("Internal error"));
        }
    }
}
