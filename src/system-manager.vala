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

    ImageData _current_image_data;
    public ImageData current_image_data {
        get {
            reload ();
            return _current_image_data;
        }
    }

    public signal void changed ();

    FileMonitor monitor;
    ulong last_con = 0;

    SystemManager () {}

    construct {
        _current_image_data = new ImageData ();

        reload ();

        File a;
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
            etc_path = Path.build_filename ("/", Config.SYSCONFDIR);
        }

        var config_file = File.new_build_filename (etc_path, "apm", "image.yml");

        try {
            var s = new Subprocess.newv ({"yq", ".", config_file.peek_path ()}, SubprocessFlags.STDOUT_PIPE);
            string json_string;
            s.communicate_utf8 (null, null, out json_string, null);
            _current_image_data.fill_from_json (json_string);

            if (last_con != 0) {
                SignalHandler.disconnect (monitor, last_con);
            }

            monitor = config_file.monitor_file (GLib.FileMonitorFlags.NONE);
            last_con = monitor.changed.connect ((file, other_file, event_type) => {
                if (event_type == FileMonitorEvent.CHANGES_DONE_HINT) {
                    changed ();
                }
            });

            changed ();

        } catch (Error e) {
            error ("Failed to read image data: %s", e.message);
        }
    }

    public void apply (ImageData new_image_data) {
        assert_not_reached ();
    }
}
