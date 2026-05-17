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

[DBus (name = "org.altlinux.APM.repo")]
public interface Repo : Object {

    public abstract async string add (
        string source,
        string date,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_add (
        string source,
        string date,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_clean (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_remove (
        string source,
        string date,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string check_set (
        string branch,
        string date,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string clean (
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string get_branches (
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string get_task_packages (
        string task_num,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string list (
        bool all,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string remove (
        string source,
        string date,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;

    public abstract async string @set (
        string branch,
        string date,
        string transaction,
        Cancellable? cancellable
    ) throws GLib.DBusError, GLib.IOError;
}

public sealed class ACC.RepoModule : Object {

    static RepoModule instance;

    DBusConnection con;
    public Repo talker { get; private set; }

    RepoModule () {
        Object ();
    }

    construct {
        try {
            con = Bus.get_sync (BusType.SYSTEM);

            if (con == null) {
                error ("Failed to connect to bus");
            }

            talker = con.get_proxy_sync<Repo> (
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

    public static RepoModule get_inst () {
        if (instance == null) {
            instance = new RepoModule ();
        }

        return instance;
    }

    public async RepoAddRemoveResponse add (
        string source,
        string date,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.add (
                source,
                date,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoAddRemoveResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoSimulateResponse check_add (
        string source,
        string date,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_add (
                source,
                date,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoSimulateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoSimulateResponse check_clean (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_clean (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoSimulateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoSimulateResponse check_remove (
        string source,
        string date,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_remove (
                source,
                date,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoSimulateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoSimulateResponse check_set (
        string branch,
        string date,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.check_set (
                branch,
                date,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoSimulateResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoAddRemoveResponse clean (
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.clean (
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoAddRemoveResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async BranchesResponse get_branches (
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.get_branches (
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<BranchesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async TaskPackagesResponse get_task_packages (
        string task_num,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.get_task_packages (
                task_num,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<TaskPackagesResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoListResponse list (
        bool all,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.list (
                all,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoListResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async RepoAddRemoveResponse remove (
        string source,
        string date,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.remove (
                source,
                date,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoAddRemoveResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }

    public async new RepoSetResponse @set (
        string branch,
        string date,
        string transaction = Uuid.string_random (),
        Cancellable? cancellable = null
    ) throws AError {
        try {
            string result = yield talker.@set (
                branch,
                date,
                transaction,
                cancellable
            );

            return Serialize.JsonWorker.simple_from_json<RepoSetResponse> (
                result,
                { "data" }
            );

        } catch (Error e) {
            throw AError.from_error (e);
        }
    }
}
