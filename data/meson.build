blueprint_files = files(
  'ui/explore-page-content.blp',
  'ui/installed-page-content.blp',
  'ui/main-page-content.blp',
  'ui/menu-button.blp',
  'ui/system-page-content.blp',
  'ui/window.blp',
)

desktop_file = i18n.merge_file(
  input: '@0@.desktop.in'.format(app_id_dyn),
  output: '@0@.desktop'.format(app_id_dyn),
  type: 'desktop',
  po_dir: '../po',
  install: true,
  install_dir: get_option('datadir') / 'applications'
)

desktop_utils = find_program('desktop-file-validate', required: false)
if desktop_utils.found()
  test('Validate desktop file', desktop_utils, args: [desktop_file])
endif

appstream_file = i18n.merge_file(
  input: '@0@.metainfo.xml.in'.format(app_id),
  output: '@0@.metainfo.xml'.format(app_id),
  po_dir: '../po',
  install: true,
  install_dir: get_option('datadir') / 'metainfo'
)

appstreamcli = find_program('appstreamcli', required: false)
if appstreamcli.found()
  test('Validate appstream file', appstreamcli, args: ['validate', appstream_file])
endif

install_data('@0@.gschema.xml'.format(app_id),
  install_dir: get_option('datadir') / 'glib-2.0' / 'schemas'
)

compile_schemas = find_program('glib-compile-schemas', required: false)
if compile_schemas.found()
  test('Validate schema file',
  compile_schemas,
  args: ['--strict', '--dry-run', meson.current_source_dir()])
endif

blueprints = custom_target('blueprints',
  input: blueprint_files,
  output: '.',
  command: [find_program('blueprint-compiler'), 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
)

resource_files = files('@0@.gresource.xml'.format(app_id))
resources = gnome.compile_resources(
  meson.project_name() + '-resources',
  resource_files,
  dependencies: blueprints,
  source_dir: meson.current_build_dir(),
  c_name: 'atomic_control_center'
)

subdir('icons')
