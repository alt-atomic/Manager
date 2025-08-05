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

public class ACC.Sys.OperationInfo : ApiBase.DataObject {

    public Gee.ArrayList<string> extra_installed { get; set; default = new Gee.ArrayList<string> (); }

    public Gee.ArrayList<string> upgraded_packages { get; set; default = new Gee.ArrayList<string> (); }

    public Gee.ArrayList<string> new_installed_packages { get; set; default = new Gee.ArrayList<string> (); }

    public Gee.ArrayList<string> removed_packages { get; set; default = new Gee.ArrayList<string> (); }

    public int upgraded_count { get; set; }

    public int new_installed_count { get; set; }

    public int removed_count { get; set; }

    public int not_upgraded_count { get; set; }
}
