vapi_sources = files(
  'config.vapi',
)

vala_sources = files(
  'apm/event-handler.vala',
  'apm/session-talker.vala',
  'apm/system-talker.vala',

  'objects/container-info.vala',
  'objects/event.vala',
  'objects/filter-info.vala',
  'objects/info.vala',
  'objects/list-params.vala',
  'objects/list.vala',
  'objects/package-info.vala',
  'objects/package.vala',
  'objects/search.vala',
  'objects/update.vala',

  'pages/explore-page-content.vala',
  'pages/installed-page-content.vala',
  'pages/main-page-content.vala',
  'pages/system-page-content.vala',
  'pages/updates-page-content.vala',

  'widgets/menu-button.vala',

  'about.vala',
  'application.vala',
  'main.vala',
  'preferences-dialog.vala',
  'system-manager.vala',
  'utils.vala',
  'window.vala',
)

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
