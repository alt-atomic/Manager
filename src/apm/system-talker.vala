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
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 * 
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

[DBus (name = "com.application.system")]
public interface System : Object {

    public abstract async string image_status (
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_switch_local (
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_update (
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string info (
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install (
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    //  public abstract async string list (
    //      string transaction
    //  ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove (
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string search (
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string update (
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;
}

public sealed class ACC.SystemTalker : Object {

    static SystemTalker instance;

    DBusConnection con;
    public System talker { get; private set; }

    SystemTalker () {
        Object ();
    }

    construct {
        Bus.get.begin (BusType.SYSTEM, null, (obj, res) => {

            try {
                con = Bus.get.end (res);

                if (con == null) {
                    error ("Failed to connect to bus");
                }

                con.get_proxy.begin<System> (
                    "com.application.APM",
                    "/com/application/APM",
                    DBusProxyFlags.NONE,
                    null,
                    (obj, res) => {

                        try {
                            talker = con.get_proxy.end<System> (res);

                            ((DBusProxy) talker).set_default_timeout (DBUS_TIMEOUT);

                            if (talker == null) {
                                error ("Failed to connect to bus");
                            }

                        } catch (IOError e) {
                            warning (e.message);

                        }
                    }
                );

            } catch (IOError e) {
                warning (e.message);
            }
        });
    }

    public static void ensure () {
        get_default ();
    }

    public static SystemTalker get_default () {
        if (instance == null) {
            instance = new SystemTalker ();
        }

        return instance;
    }
}
