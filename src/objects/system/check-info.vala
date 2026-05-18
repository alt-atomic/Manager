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

public sealed class ACC.Objects.OperationInfo : Serialize.DataObject {

    public string[] extra_installed { get; set; }

    public string[] upgraded_pacakges { get; set; }

    public string[] new_installed_packages { get; set; }

    public string[] removed_packages { get; set; }

    public string[] kept_back_pacakges { get; set; }

    public int upgraded_count { get; set; }

    public int new_installed_count { get; set; }

    public int removed_count { get; set; }

    public int kept_back_count { get; set; }

    public int not_upgraded_count { get; set; }

    public int64 download_size { get; set; }

    public int64 install_size { get; set; }

    public Serialize.Array<CheckEssentialPackageInfo> essential_packages {
        get; set; default = new Serialize.Array<CheckEssentialPackageInfo> ();
    }
}
