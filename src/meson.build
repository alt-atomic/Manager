vapi_sources = files(
  'config.vapi',
)

vala_sources = files(
  'apm/distrobox-module.vala',
  'apm/event-handler.vala',
  'apm/kernel-module.vala',
  'apm/repo-module.vala',
  'apm/system-module.vala',

  'dbus/service.vala',

  'pages/explore-page-content.vala',
  'pages/library-page-content.vala',
  'pages/main-page-content.vala',
  'pages/search-page-content.vala',
  'pages/system-page-content.vala',

  'widgets/menu-button.vala',

  'about.vala',
  'application.vala',
  'errors.vala',
  'main.vala',
  'preferences-dialog.vala',
  'utils.vala',
  'window.vala',
)

subdir('objects')

sources = [
  vala_sources,
  vapi_sources,
  resources,
]

executable(
  meson.project_name(),
  sources,
  include_directories: config_h_dir,
  dependencies: dependencies,
  install: true,
)
