/*
 * Copyright (C) 2025-2026 Vladimir Romanov <rirusha@altlinux.org>
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

using ACC.Objects;

[DBus (name = "org.altlinux.APM.system")]
public interface System : Object {

    public abstract async string application_categories (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string application_get_filter_fields (
        string pkgname,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string application_info (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string application_list (
        string sort,
        string order,
        int limit,
        int offset,
        string filters_j_s_o_n,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string application_update (
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_install (
        string[] packages,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_remove (
        string[] packages,
        bool depends,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_upgrade (
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string get_apt_config_overrides (
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string get_filter_fields (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_apply (
        string transaction,
        bool background,
        bool pull_image,
        bool no_cache,
        string config_path,
        string workdir,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_get_config (
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_history (
        string transaction,
        string image_name,
        int limit,
        int offset,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_save_config (
        string config,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_status (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string image_update (
        string transaction,
        bool background,
        bool no_cache,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string info (
        string package_name,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install (
        string[] packages,
        bool download_only,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list (
        string sort,
        string order,
        int limit,
        int offset,
        string filters_j_s_o_n,
        bool force_update,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string multi_info (
        string[] packages,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove (
        string[] packages,
        bool purge,
        bool depends,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string search (
        string package_name,
        string transaction,
        bool installed,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string sections (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string set_apt_config_overrides (
        HashTable<string, string> options,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string update (
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string upgrade (
        bool download_only,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;
}

public sealed class ACC.SystemModule : Object {

    static SystemModule instance;

    DBusConnection con;
    public System talker { get; private set; }

    SystemModule () {
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
        get_inst ();
    }

    public static SystemModule get_inst () {
        if (instance == null) {
            instance = new SystemModule ();
        }

        return instance;
    }

    public async ApplicationCategoriesResponse application_categories (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.application_categories (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ApplicationCategoriesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ApplicationFilterFieldsAppStreamResponse application_get_filter_fields (
        string pkgname,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.application_get_filter_fields (
                pkgname,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ApplicationFilterFieldsAppStreamResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ApplicationInfoResponse application_info (
        string pkgname,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.application_info (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ApplicationInfoResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ApplicationListResponse application_list (
        string sort,
        string order,
        int limit,
        int offset,
        string filters_j_s_o_n,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.application_list (
                sort,
                order,
                limit,
                offset,
                filters_j_s_o_n,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ApplicationListResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ApplicationUpdateResponse application_update (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.application_update (
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ApplicationUpdateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async CheckResponse check_install (
        string[] packages,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_install (
                packages,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<CheckResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async CheckResponse check_remove (
        string[] packages,
        bool depends,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_remove (
                packages,
                depends,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<CheckResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async CheckResponse check_upgrade (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_upgrade (
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<CheckResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async AptConfigResponse get_apt_config_overrides (
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.get_apt_config_overrides (
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<AptConfigResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Serialize.Array<FilterFieldsInfo> get_filter_fields (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.get_filter_fields (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_array_from_json<FilterFieldsInfo> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ImageApplyResponse image_apply (
        bool pull_image,
        bool no_cache,
        string config_path,
        string workdir,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_apply (
                transaction,
                false,
                pull_image,
                no_cache,
                config_path,
                workdir,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ImageApplyResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Config image_get_config (
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_get_config (
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<Objects.Config> (
                result,
                { "data", "config" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Serialize.Array<ImageHistoryRecord> image_history (
        string image_name,
        int limit,
        int offset,
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

            return Serialize.JsonWorker.simple_array_from_json<ImageHistoryRecord> (
                result,
                { "data", "history" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Config image_save_config (
        Objects.Config config,
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_save_config (
                config.to_json (),
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<Objects.Config> (
                result,
                { "data", "config" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async BootImageInfo image_status (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_status (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<BootImageInfo> (
                result,
                { "data", "bootedImage" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async BootImageInfo image_update (
        bool no_cache,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.image_update (
                transaction,
                false,
                no_cache,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<BootImageInfo> (
                result,
                { "data", "bootedImage" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async PackageInfo info (
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

            return Serialize.JsonWorker.simple_from_json<PackageInfo> (
                result,
                { "data", "packageInfo" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async OperationInfo install (
        string[] packages,
        bool download_only,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.install (
                packages,
                download_only,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<OperationInfo> (
                result,
                { "data", "info" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ListResponse list (
        string sort,
        string order,
        int limit,
        int offset,
        string filters_j_s_o_n,
        bool force_update,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.list (
                sort,
                order,
                limit,
                offset,
                filters_j_s_o_n,
                force_update,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ListResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async MultiInfoResponse multi_info (
        string[] packages,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.multi_info (
                packages,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<MultiInfoResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async OperationInfo remove (
        string[] packages,
        bool purge,
        bool depends,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.remove (
                packages,
                purge,
                depends,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<OperationInfo> (
                result,
                { "data", "info" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async SearchResponse search (
        string package_name,
        bool installed,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.search (
                package_name,
                transaction,
                installed,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<SearchResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async SectionsResponse sections (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.sections (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<SectionsResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async AptConfigResponse set_apt_config_overrides (
        HashTable<string, string> options,
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.set_apt_config_overrides (
                options,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<AptConfigResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async UpdateResponse update (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.update (
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<UpdateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async UpgradeResponse upgrade (
        bool download_only,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.upgrade (
                download_only,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<UpgradeResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }
}
