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

[DBus (name = "org.altlinux.distrobox")]
public interface Distrobox : Object {

    public abstract async string container_add (
        string image,
        string name,
        string additional_packages,
        string init_hooks,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string container_list (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string container_remove (
        string name,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string get_filter_fields (
        string container,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async uint8[] get_icon_by_package (
        string package_name,
        string container,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string info (
        string container,
        string package_name,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install (
        string container,
        string package_name,
        bool export,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list (
        string params_j_s_o_n,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove (
        string container,
        string package_name,
        bool only_export,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string search (
        string container,
        string package_name,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string update (
        string container,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;
}

public sealed class ACC.SessionTalker : Object {

    static SessionTalker instance;

    DBusConnection con;
    Distrobox talker;

    SessionTalker () {
        Object ();
    }

    construct {
        try {
            con = Bus.get_sync (BusType.SESSION);

            if (con == null) {
                error ("Failed to connect to bus");
            }

            talker = con.get_proxy_sync<Distrobox> (
                "org.altlinux.APM",
                "/org/altlinux/APM",
                DBusProxyFlags.NONE
            );

            ((DBusProxy) talker).set_default_timeout (DBUS_TIMEOUT);

            if (talker == null) {
                error ("Failed to connect to bus");
            }

        } catch (IOError e) {
            warning (e.message);
        }
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

    public async ContainerInfo container_add (
        string image,
        string name,
        string additional_packages = "",
        string init_hooks = "",
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.container_add (
                image,
                name,
                additional_packages,
                init_hooks,
                transaction,
                cancellable
            );

            var obj = new ContainerInfo ();
            obj.fill_from_json (
                result,
                { "data", "containerInfo" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async ContainerInfo[] container_list (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.container_list (
                transaction,
                cancellable
            );

            var obj_array = new Gee.ArrayList<ContainerInfo> ();

            var jsoner = new ApiBase.Jsoner (result, { "data", "containers" }, ApiBase.Case.CAMEL);
            yield jsoner.deserialize_array_into_async (obj_array);

            return obj_array.to_array ();

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async ContainerInfo container_remove (
        string image,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.container_remove (
                image,
                transaction,
                cancellable
            );

            var obj = new ContainerInfo ();
            obj.fill_from_json (
                result,
                { "data", "containerInfo" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async FilterInfo[] get_filter_fields (
        string container,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.get_filter_fields (
                container,
                transaction,
                cancellable
            );

            var obj_array = new Gee.ArrayList<FilterInfo> ();

            var jsoner = new ApiBase.Jsoner (result, { "data" }, ApiBase.Case.CAMEL);
            jsoner.deserialize_object_into (obj_array);

            return obj_array.to_array ();

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Gdk.Texture? get_icon_by_package (
        string package_name,
        string container,
        Cancellable? cancellable = null
    ) throws AError {
        try {
            uint8[] result = yield talker.get_icon_by_package (
                package_name,
                container,
                cancellable
            );

            return Gdk.Texture.from_bytes (new Bytes (result));

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        } catch (Error e) {
            return null;
        }
    }

    public async Info info (
        string container,
        string package_name,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.info (
                container,
                package_name,
                transaction,
                cancellable
            );

            var obj = new Info ();
            obj.fill_from_json (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Info install (
        string container,
        string package_name,
        bool export = false,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.install (
                container,
                package_name,
                export,
                transaction,
                cancellable
            );

            var obj = new Info ();
            obj.fill_from_json (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async List list (
        string container,
        string sort = "",
        ListParamsOrder order = ListParamsOrder.ASC,
        int limit = 10,
        int offset = 10,
        string[] filter_field = {},
        bool force_update = false,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.list (
                new ListParams () {
                    container = container,
                    sort = sort,
                    order = order,
                    limit = limit,
                    offset = offset,
                    filters = new Gee.ArrayList<string>.wrap (filter_field),
                    force_update = force_update
                }.to_json (),
                transaction,
                cancellable
            );

            var obj = new List ();
            obj.fill_from_json (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Info remove (
        string container,
        string package_name,
        bool only_export = false,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.remove (
                container,
                package_name,
                only_export,
                transaction,
                cancellable
            );

            var obj = new Info ();
            obj.fill_from_json (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Search search (
        string container,
        string package_name,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.search (
                container,
                package_name,
                transaction,
                cancellable
            );

            var obj = new Search ();
            obj.fill_from_json (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Update update (
        string container,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.update (
                container,
                transaction,
                cancellable
            );

            var obj = new Update ();
            obj.fill_from_json (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );
            return obj;

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.CommonError e) {
            throw AError.get_base_internal ();
        }
    }
}
