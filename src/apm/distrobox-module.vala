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

[DBus (name = "org.altlinux.distrobox")]
public interface Distrobox : Object {

    public abstract async string container_add (
        string image,
        string name,
        string additional_packages,
        string init_hooks,
        string transaction,
        bool background,
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
        string container,
        string sort,
        string order,
        int limit,
        int offset,
        string filters_j_s_o_n,
        bool force_update,
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

public sealed class ACC.DistroboxModule : Object {

    static DistroboxModule instance;

    DBusConnection con;
    Distrobox talker;

    DistroboxModule () {
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
        get_inst ();
    }

    public static DistroboxModule get_inst () {
        if (instance == null) {
            instance = new DistroboxModule ();
        }

        return instance;
    }

    public async ContainerInfo container_add (
        string image,
        string name,
        string additional_packages,
        string init_hooks,
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
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ContainerInfo> (
                result,
                { "data", "containerInfo" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Serialize.Array<ContainerInfo> container_list (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.container_list (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_array_from_json<ContainerInfo> (
                result,
                { "data", "containers" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ContainerInfo container_remove (
        string name,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.container_remove (
                name,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ContainerInfo> (
                result,
                { "data", "containerInfo" }
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

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Distrobox.PackageInfo info (
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

            return Serialize.JsonWorker.simple_from_json<Objects.Distrobox.PackageInfo> (
                result,
                { "data", "packageInfo" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Distrobox.PackageInfo install (
        string container,
        string package_name,
        bool export,
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

            return Serialize.JsonWorker.simple_from_json<Objects.Distrobox.PackageInfo> (
                result,
                { "data", "packageInfo" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Distrobox.ListResponse list (
        string container,
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
                container,
                sort,
                order,
                limit,
                offset,
                filters_j_s_o_n,
                force_update,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<Objects.Distrobox.ListResponse> (
                result,
                { "data", "packageInfo" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Distrobox.PackageInfo remove (
        string container,
        string package_name,
        bool only_export,
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

            return Serialize.JsonWorker.simple_from_json<Objects.Distrobox.PackageInfo> (
                result,
                { "data", "packageInfo" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Serialize.Array<Objects.Distrobox.Package> search (
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

            return Serialize.JsonWorker.simple_array_from_json<Objects.Distrobox.Package> (
                result,
                { "data", "packages" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Objects.Distrobox.UpdateResponse update (
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

            return Serialize.JsonWorker.simple_from_json<Objects.Distrobox.UpdateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }
}
