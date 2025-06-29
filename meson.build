project(
  'atomic-control-center',
  'vala',
  version: '0.1.0',
  meson_version: '>= 1.0.0',
  license: 'GPL-3.0-or-later',
)

app_name = 'Atomic Control Center'

app_id = 'org.altlinux.AtomicControlCenter'
app_id_dyn = app_id

developer_name = 'Vladimir Vaskov'
developer_data = 'Vladimir Vaskov <rirusha@altlinux.org>'

glib_min_version = '2.76'

gee_dep = dependency('gee-0.8')
libadwaita_dep = dependency('libadwaita-1', version: '>= 1.6')
libapi_base_dep = dependency('libapi-base-2', version: '>= 2.1', fallback : ['libapi-base', 'lib_dep'])
libportal_dep = dependency('libportal')

dependencies = [
  gee_dep,
  libadwaita_dep,
  libapi_base_dep,
  libportal_dep,
]

add_project_arguments(
  '-include', 'config.h',
  '-w',
  language: ['c']
)

add_project_arguments(
  '--target-glib', glib_min_version,
  '--vapidir', meson.current_source_dir(),
  language: ['vala']
)

i18n = import('i18n')
gnome = import('gnome')

if get_option('is_devel')
  app_name += ' (Devel)'
  app_id_dyn += '.Devel'
endif

conf = configuration_data()
conf.set_quoted('APP_NAME', app_name)
conf.set_quoted('APP_ID', app_id)
conf.set_quoted('APP_ID_DYN', app_id_dyn)
conf.set_quoted('DEVELOPER_NAME', developer_name)
conf.set_quoted('DEVELOPER_DATA', developer_data)
conf.set_quoted('G_LOG_DOMAIN', app_id)
conf.set10('IS_DEVEL', get_option('is_devel'))
conf.set_quoted('VERSION', meson.project_version())
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf.set_quoted('DATADIR', get_option('prefix') / get_option('datadir'))
conf.set_quoted('SYSCONFDIR', get_option('sysconfdir'))
conf.set_quoted('GNOMELOCALEDIR', get_option('prefix') / get_option('localedir'))

configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

subdir('data')
subdir('po')
subdir('src')

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true,
)
