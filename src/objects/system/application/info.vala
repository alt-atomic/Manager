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

public sealed class ACC.Objects.ApplicationInfo : Serialize.DataObject {

    [Description (name = "type")]
    public string type_ { get; set; }

    public string id { get; set; }

    public string metadata_license { get; set; }

    public string project_license { get; set; }

    public Serialize.Dict<string> name { get; set; default = new Serialize.Dict<string> (); }

    public Serialize.Dict<string> summary { get; set; default = new Serialize.Dict<string> (); }

    public Serialize.Dict<string> description { get; set; default = new Serialize.Dict<string> (); }

    public Serialize.Dict<string> developer_name { get; set; default = new Serialize.Dict<string> (); }

    public ApplicationDeveloperInfo developer { get; set; }

    public string project_group { get; set; }

    public string[] keywords { get; set; }

    public string[] categories { get; set; }

    public Serialize.Dict<string> urls { get; set; default = new Serialize.Dict<string> (); }

    public Serialize.Array<ApplicationScreenshotInfo> screenshots {
        get; set; default = new Serialize.Array<ApplicationScreenshotInfo> ();
    }

    public Serialize.Array<ApplicationReleaseInfo> releases {
        get; set; default = new Serialize.Array<ApplicationReleaseInfo> ();
    }

    public Serialize.Array<ApplicationIconInfo> icons {
        get; set; default = new Serialize.Array<ApplicationIconInfo> ();
    }

    public Serialize.Dict<string> launchable { get; set; default = new Serialize.Dict<string> (); }

    public ApplicationContentRatingInfo content_rating { get; set; }

    public ApplicationProvidesInfo provides { get; set; }

    public string[] extends { get; set; }

    public Serialize.Array<ApplicationBrandingInfo> branding {
        get; set; default = new Serialize.Array<ApplicationBrandingInfo> ();
    }

    public Serialize.Array<ApplicationTranslationInfo> translations {
        get; set; default = new Serialize.Array<ApplicationTranslationInfo> ();
    }

    public Serialize.Array<ApplicationLanguageInfo> languages {
        get; set; default = new Serialize.Array<ApplicationLanguageInfo> ();
    }

    public Serialize.Dict<string> custom { get; set; default = new Serialize.Dict<string> (); }

    public string[] kudos { get; set; }

    public string[] mimetypes { get; set; }

    public ApplicationPropertyInfo @requires { get; set; }

    public ApplicationPropertyInfo recommends { get; set; }

    public ApplicationPropertyInfo supports { get; set; }

    public string[] suggests { get; set; }

    public string[] replaces { get; set; }

    public string[] compulsory_for_desktop { get; set; }

    public string update_contact { get; set; }

    public string pkgname { get; set; }
}
