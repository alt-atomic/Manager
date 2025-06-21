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
 * along with this program. If not, see
 * <https://www.gnu.org/licenses/gpl-3.0-standalone.html>.
 * 
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public sealed class ACC.SystemManager : Object {

    static SystemManager instance;

    public string image { get; set; }

    public Gee.ArrayList<string> install { get; set; default = new Gee.ArrayList<string> (); }

    public Gee.ArrayList<string> remove { get; set; default = new Gee.ArrayList<string> (); }

    public Gee.ArrayList<string> custom_commands { get; set; default = new Gee.ArrayList<string> (); }

    public signal void changed ();

    SystemManager () {}

    construct {
        reload ();
    }

    public static SystemManager get_default () {
        if (instance == null) {
            instance = new SystemManager ();
        }

        return instance;
    }

    public void reload () {
        string etc_path;

        if (Xdp.Portal.running_under_flatpak ()) {
            etc_path = "/run/host/etc";
        } else {
            etc_path = Config.SYSCONFDIR;
        }

        string image_data;
        try {
            FileUtils.get_contents (Path.build_filename (etc_path, "apm", "image.yml"), out image_data);
        } catch (Error e) {
            warning (e.message);
        }
    }

    public void apply () {

    }
}
