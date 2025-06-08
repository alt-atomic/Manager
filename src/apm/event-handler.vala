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

[DBus (name = "org.altlinux.APM")]
interface Apm : Object {
    public signal void notification (string data);
}

public sealed class ACC.EventHandler : Object {

    static EventHandler instance_session;
    static EventHandler instance_system;

    public BusType bus_type { get; construct; }

    public signal void event_recieved (Event event);

    DBusConnection con;
    Apm apm_talker;

    EventHandler (BusType bus_type) {
        Object (bus_type: bus_type);
    }

    construct {
        Bus.get.begin (bus_type, null, (obj, res) => {

            try {
                con = Bus.get.end (res);

                if (con == null) {
                    error ("Failed to connect to bus");
                }

                con.get_proxy.begin<Apm> (
                    "org.altlinux.APM",
                    "/org/altlinux/APM",
                    DBusProxyFlags.NONE,
                    null,
                    (obj, res) => {
                        try {
                            apm_talker = con.get_proxy.end<Apm> (res);

                            ((DBusProxy) apm_talker).set_default_timeout (DBUS_TIMEOUT);

                            if (apm_talker == null) {
                                error ("Failed to connect to bus");
                            }

                            apm_talker.notification.connect ((data) => {
                                try {
                                    var jsoner = new ApiBase.Jsoner (data, null, ApiBase.Case.CAMEL);
                                    event_recieved ((Event) jsoner.deserialize_object (typeof (Event)));

                                } catch (ApiBase.CommonError e) {
                                    warning (e.message);
                                }
                            });

                        } catch (IOError e) {
                            warning (@"$bus_type: $(e.message)");

                        }
                    }
                );

            } catch (IOError e) {
                warning (@"$bus_type: $(e.message)");
            }
        });
    }

    public static void ensure () {
        get_default_session ();
        get_default_system ();
    }

    public static EventHandler get_default_session () {
        if (instance_session == null) {
            instance_session = new EventHandler (BusType.SESSION);
        }

        return instance_session;
    }

    public static EventHandler get_default_system () {
        if (instance_system == null) {
            instance_system = new EventHandler (BusType.SYSTEM);
        }

        return instance_system;
    }
}
