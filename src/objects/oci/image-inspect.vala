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

public sealed class ACC.Objects.ImageInspect : Serialize.DataObject {

    public string name { get; set; }

    public string digest { get; set; }

    public string[] repo_tags { get; set; }

    public string created { get; set; }

    public string docker_version { get; set; }

    public Serialize.Dict<string> labels { get; set; default = new Serialize.Dict<string> (); }

    public string architecture { get; set; }

    public string os { get; set; }

    public string[] layers { get; set; }

    public Serialize.Array<LayerData> layers_data { get; set; default = new Serialize.Array<LayerData> (); }

    public Serialize.Dict<string> env { get; set; default = new Serialize.Dict<string> (); }
}
