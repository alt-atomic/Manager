/* Copyright 2024 <<DEVELOPER-DATA>>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace <<APP-NAMESPACE>> {
    public Adw.AboutDialog build_about () {
        string[] developers = {
            Config.DEVELOPER_DATA,
        };

        return new Adw.AboutDialog () {
            application_name = Config.APP_NAME,
            application_icon = Config.APP_ID_DYN,
            developer_name = Config.DEVELOPER_NAME,
            version = Config.VERSION,
            developers = developers,
            // Translators: NAME <EMAIL.COM> or NAME SITE.ORG
            translator_credits = _("translator-credits"),
            license_type = Gtk.License.GPL_3_0,
            copyright = "© 2024 " + Config.DEVELOPER_NAME,
            release_notes_version = Config.VERSION
        };
    }
}
