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

    public abstract async string check_install (
        string[] packages,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_remove (
        string[] packages,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_apply (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_history (
        string transaction,
        string image_name,
        int64 limit,
        int64 offset,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_status (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_update (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string info (
        string package_name,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install (
        string[] packages,
        bool apply_atomic,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list (
        string params_j_s_o_n,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove (
        string[] packages,
        bool apply_atomic,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string search (
        string package_name,
        string transaction,
        bool installed,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string update (
        string transaction,
        Cancellable? cancellable
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
