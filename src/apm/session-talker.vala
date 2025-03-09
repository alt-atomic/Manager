/*
 * Copyright (C) 2025 Vladimir Vaskov
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

[DBus (name = "com.application.distrobox")]
public interface Distrobox : Object {

    public abstract async string container_add (
        string image,
        string name,
        string additional_packages,
        string init_hooks,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string contaner_list (
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string container_remove (
        string name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string info (
        string container,
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install (
        string container,
        string package_name,
        bool export,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list (
        string params_j_s_o_n,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove (
        string container,
        string package_name,
        bool only_export,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string search (
        string container,
        string package_name,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string update (
        string container,
        string transaction
    ) throws GLib.DBusError, GLib.IOError;
}

public sealed class Manager.SessionTalker : Object {

    static SessionTalker instance;

    DBusConnection con;
    public Distrobox talker { get; private set; }

    SessionTalker () {
        Object ();
    }

    construct {
        Bus.get.begin (BusType.SESSION, null, (obj, res) => {

            try {
                con = Bus.get.end (res);

                if (con == null) {
                    error ("Failed to connect to bus");
                }

                con.get_proxy.begin<Distrobox> (
                    "com.application.APM",
                    "/com/application/APM",
                    DBusProxyFlags.NONE,
                    null,
                    (obj, res) => {

                        try {
                            talker = con.get_proxy.end<Distrobox> (res);

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

    public static SessionTalker get_default () {
        if (instance == null) {
            instance = new SessionTalker ();
        }

        return instance;
    }
}
