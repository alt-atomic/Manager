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

[DBus (name = "org.altlinux.APM.kernel")]
public interface Kernel : Object {

    public abstract async string check_clean_old_kernels (
        bool no_backup,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_install_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_install_kernel_modules (
        string flavour,
        string[] modules,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_remove_kernal_modules (
        string flavour,
        string[] modules,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_update_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string clean_old_kernels (
        bool no_backup,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string get_current_kernel (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string install_kernel_modules (
        string flavour,
        string[] modules,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list_kernel_modules (
        string flavour,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list_kernels (
        string flavour,
        bool installed_only,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove_kernal_modules (
        string flavour,
        string[] modules,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string update_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction,
        bool background,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;
}

public sealed class ACC.KernelModule : Object {

    static KernelModule instance;

    DBusConnection con;
    public Kernel talker { get; private set; }

    KernelModule () {
        Object ();
    }

    construct {
        try {
            con = Bus.get_sync (BusType.SYSTEM);

            if (con == null) {
                error ("Failed to connect to bus");
            }

            talker = con.get_proxy_sync<Kernel> (
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

    public static KernelModule get_inst () {
        if (instance == null) {
            instance = new KernelModule ();
        }

        return instance;
    }

    public async CleanOldKernelsResponse check_clean_old_kernels (
        bool no_backup,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_clean_old_kernels (
                no_backup,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<CleanOldKernelsResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async InstallUpdateKernelResponse check_install_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_install_kernel (
                flavour,
                modules,
                include_headers,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<InstallUpdateKernelResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async InstallKernelModulesResponse check_install_kernel_modules (
        string flavour,
        string[] modules,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_install_kernel_modules (
                flavour,
                modules,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<InstallKernelModulesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RemoveKernelModulesResponse check_remove_kernal_modules (
        string flavour,
        string[] modules,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_remove_kernal_modules (
                flavour,
                modules,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RemoveKernelModulesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async InstallUpdateKernelResponse check_update_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_update_kernel (
                flavour,
                modules,
                include_headers,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<InstallUpdateKernelResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async CleanOldKernelsResponse clean_old_kernels (
        bool no_backup,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.clean_old_kernels (
                no_backup,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<CleanOldKernelsResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async KernelInfo get_current_kernel (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.get_current_kernel (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<KernelInfo> (
                result,
                { "data", "kernel" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async InstallUpdateKernelResponse install_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.install_kernel (
                flavour,
                modules,
                include_headers,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<InstallUpdateKernelResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async InstallKernelModulesResponse install_kernel_modules (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.install_kernel_modules (
                flavour,
                modules,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<InstallKernelModulesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async ListKernelModulesResponse list_kernel_modules (
        string flavour,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.list_kernel_modules (
                flavour,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<ListKernelModulesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async Serialize.Array<KernelInfo> list_kernels (
        string flavour,
        bool installed_only,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.list_kernels (
                flavour,
                installed_only,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_array_from_json<KernelInfo> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RemoveKernelModulesResponse remove_kernal_modules (
        string flavour,
        string[] modules,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.remove_kernal_modules (
                flavour,
                modules,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RemoveKernelModulesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async InstallUpdateKernelResponse update_kernel (
        string flavour,
        string[] modules,
        bool include_headers,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.update_kernel (
                flavour,
                modules,
                include_headers,
                transaction,
                false,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<InstallUpdateKernelResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }
}
