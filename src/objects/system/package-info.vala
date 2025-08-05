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

public enum PackageType {
    SYSTEM,
    STPLR
}

public sealed class ACC.Sys.PackageInfo : ApiBase.DataObject {

    public string name { get; set; }

    public string section { get; set; }

    public int64 installed_size { get; set; }

    public string maintainer { get; set; }

    public string version { get; set; }

    public string version_installed { get; set; }

    public Gee.ArrayList<string> depends { get; set; default = new Gee.ArrayList<string> (); }

    public Gee.ArrayList<string> provides { get; set; default = new Gee.ArrayList<string> (); }

    public int64 size { get; set; }

    public string filename { get; set; }

    public string description { get; set; }

    public string last_changelog { get; set; }

    public bool installed { get; set; }

    public int type_package { get; set; }
}
