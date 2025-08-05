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

[GtkTemplate (ui = "/org/altlinux/AtomicControlCenter/ui/installed-page-content.ui")]
public sealed class ACC.InstalledPageContent: Adw.Bin {

    [GtkChild]
    unowned Gtk.ScrolledWindow scrolled_window;
    [GtkChild]
    unowned Gtk.ListBox list_box;

    int last_offset = 0;
    bool working = false;

    construct {
        load_next.begin ();
    }

    async void load_next () {
        if (working) {
            return;
        }
        working = true;

        var list = yield SystemTalker.get_default ().list ("", ASC, 10, last_offset);

        foreach (var item in list.packages) {
            list_box.append (new Adw.ActionRow () {
                title = item.name,
                subtitle = item.description
            });
        }
        last_offset += 10;
        working = false;
    }

    [GtkCallback]
    void on_button_activated () {
        load_next.begin ();
    }
}
