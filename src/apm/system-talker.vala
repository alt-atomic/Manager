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

[DBus (name = "org.altlinux.APM.system")]
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

    public abstract async string check_update_kernel (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_upgrade (
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
        try {
            con = Bus.get_sync (BusType.SYSTEM);

            if (con == null) {
                error ("Failed to connect to bus");
            }

            talker = con.get_proxy_sync<System> (
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

    public static SystemTalker get_default () {
        if (instance == null) {
            instance = new SystemTalker ();
        }

        return instance;
    }

    public async Sys.OperationInfo check_install (
        string[] packages,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_install (
                packages,
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.OperationInfo> (
                result,
                { "data", "info" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.OperationInfo check_remove (
        string[] packages,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_remove (
                packages,
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.OperationInfo> (
                result,
                { "data", "info" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    //  public async void check_update_kernel (
    //      string transaction = Uuid.string_random (),
    //      Cancellable? cancellable = null
    //  ) throws AError {
    //      try {
    //          string result = yield talker.check_update_kernel (
    //              transaction,
    //              cancellable
    //          );

    //          assert_not_reached ();

    //      } catch (IOError e) {
    //          error (e.message);
    //      } catch (DBusError e) {
    //          throw AError.from_dbus_error (e);
    //      } catch (ApiBase.JsonError e) {
    //          throw AError.get_base_internal ();
    //      }
    //  }

    public async Sys.OperationInfo check_upgrade (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_upgrade (
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.OperationInfo> (
                result,
                { "data", "info" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.BootedImage image_apply (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_apply (
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.BootedImage> (
                result,
                { "data", "bootedImage" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Gee.ArrayList<Sys.HistoryRecord> image_history (
        string image_name = "",
        int64 limit = 50,
        int64 offset = 0,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_history (
                transaction,
                image_name,
                limit,
                offset,
                cancellable
            );

            return ApiBase.Jsoner.simple_array_from_json<Sys.HistoryRecord> (
                result,
                { "data", "history" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.BootedImage image_status (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_status (
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.BootedImage> (
                result,
                { "data", "bootedImage" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.BootedImage image_update (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_update (
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.BootedImage> (
                result,
                { "data", "bootedImage" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.PackageInfo info (
        string package_name,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.info (
                package_name,
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.PackageInfo> (
                result,
                { "data", "packageInfo" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.OperationInfo install (
        string[] packages,
        bool apply_atomic,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.install (
                packages,
                apply_atomic,
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.OperationInfo> (
                result,
                { "data", "info" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.PackagesInfo list (
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
                new Sys.ListParams () {
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

            return ApiBase.Jsoner.simple_from_json<Sys.PackagesInfo> (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.OperationInfo remove (
        string[] packages,
        bool apply_atomic,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.remove (
                packages,
                apply_atomic,
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.OperationInfo> (
                result,
                { "data", "info" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }

    public async Sys.PackagesInfo update (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.update (
                transaction,
                cancellable
            );

            return ApiBase.Jsoner.simple_from_json<Sys.PackagesInfo> (
                result,
                { "data" },
                ApiBase.Case.CAMEL
            );

        } catch (IOError e) {
            error (e.message);
        } catch (DBusError e) {
            throw AError.from_dbus_error (e);
        } catch (ApiBase.JsonError e) {
            throw AError.get_base_internal ();
        }
    }
}
