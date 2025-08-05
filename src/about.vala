/* Copyright (C) 2025 Vladimir Vaskov <rirusha@altlinux.org>
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

namespace ACC {
    public Adw.AboutDialog build_about () {
        return new Adw.AboutDialog.from_appdata (
            @"/org/altlinux/AtomicControlCenter/org.altlinux.AtomicControlCenter.metainfo.xml",
            Config.VERSION
        ) {
            application_icon = Config.APP_ID,
            artists = {

            },
            developers = {
                "Vladimir Vaskob <rirusha@altlinux.org>"
            },
            // Translators: NAME <EMAIL.COM> /n NAME <EMAIL.COM>
            translator_credits = _("translator-credits"),
            copyright = "© 2025 ALT Linux Team"
        };
    }
}
