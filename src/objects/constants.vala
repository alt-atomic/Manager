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

namespace ACC.EventName.System {
    const string INSTALL = "system.Install";
    const string REMOVE = "system.Remove";
    const string UPDATE = "system.Update";
    const string UPGRADE = "system.Upgrade";
    const string CHECK_INSTALL = "system.CheckInstall";
    const string CHECK_REMOVE = "system.CheckRemove";
    const string CHECK_UPGRADE = "system.CheckUpgrade";
    const string IMAGE_UPDATE = "system.ImageUpdate";
    const string IMAGE_APPLY = "system.ImageApply";
    const string APT_UPDATE = "system.AptUpdate";
    const string SAVE_PACKAGES_TO_DB = "system.SavePackagesToDB";
    const string SAVE_IMAGE_TO_DB = "system.SaveImageToDB";
    const string BUILD_IMAGE = "system.BuildImage";
    const string SWITCH_IMAGE = "system.SwitchImage";
    const string CHECK_UPDATE_BASE_IMAGE = "system.CheckAndUpdateBaseImage";
    const string BOOTC_UPGRADE = "system.bootcUpgrade";
    const string PRUNE_OLD_IMAGES = "system.pruneOldImages";
    const string UPDATE_ALL_PACKAGES_DB = "system.updateAllPackagesDB";
    const string UPDATE_APP_STREAM = "system.UpdateAppStream";
    const string DOWNLOAD_PROGRESS = "system.downloadProgress";
    const string PULL_IMAGE = "system.pullImage";
}

namespace ACC.EventName.Kernel {
    const string INSTALL = "kernel.InstallKernel";
    const string CHECK_INSTALL = "kernel.CheckInstallKernel";
    const string UPDATE = "kernel.UpdateKernel";
    const string CHECK_UPDATE = "kernel.CheckUpdateKernel";
    const string CLEAN = "kernel.CleanOldKernels";
    const string CHECK_CLEAN = "kernel.CheckCleanOldKernels";
    const string INSTALL_MODS = "kernel.InstallKernelModules";
    const string CHECK_INSTALL_MODS = "kernel.CheckInstallKernelModules";
    const string REMOVE_MODS = "kernel.RemoveKernelModules";
    const string CHECK_REMOVE_MODS = "kernel.CheckRemoveKernelModules";
}

namespace ACC.EventName.Distrobox {
    const string UPDATE = "distrobox.Update";
    const string CONTAINER_ADD = "distrobox.ContainerAdd";
    const string SAVE_PACKAGES_TO_DB = "distro.SavePackagesToDB";
    const string CREATE_CONTAINER = "distro.CreateContainer";
    const string REMOVE_CONTAINER = "distro.RemoveContainer";
    const string INSTALL_PACKAGE = "distro.InstallPackage";
    const string REMOVE_PACKAGE = "distro.RemovePackage";
    const string UPDATE_PACKAGES = "distro.UpdatePackages";
    const string GET_PACKAGES = "distro.GetPackages";
}
