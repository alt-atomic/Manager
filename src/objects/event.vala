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

public enum EventState {
    BEFORE,
    AFTER,
}

public enum EventType {
    NOTIFICATION,
    PROGRESS,
}

public sealed class ACC.Event : ApiBase.DataObject {

    public string name { get; set; }

    public string message { get; set; }

    public EventState state { get; set; }

    public EventType type_ { get; set; }

    public int progress { get; set; }

    public string transaction { get; set; }
}
