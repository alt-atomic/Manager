project(
  'atomic-control-center',
  'vala',
  version: '0.1.0',
  meson_version: '>= 1.0.0',
  license: 'GPL-3.0-or-later',
)

app_id = 'org.altlinux.Software'

glib_min_version = '2.76'

nightly = false

gee_dep = dependency('gee-0.8')
libadwaita_dep = dependency('libadwaita-1', version: '>= 1.6')
libapi_base_dep = dependency('libserialize-7', version: '>= 7.5', fallback : ['libapi-base', 'serialize_lib_dep'])
libcassette_dep = dependency('libcassette-0')

dependencies = [
  gee_dep,
  libadwaita_dep,
  libapi_base_dep,
  libcassette_dep,
]

add_project_arguments(
  '-include', 'config.h',
  '-w',
  language: ['c']
)

add_project_arguments(
  '--target-glib', glib_min_version,
  '--vapidir', meson.current_source_dir(),
  '--vapidir', meson.current_source_dir() / 'vapi',
  language: ['vala']
)

i18n = import('i18n')
py = import('python')
gnome = import('gnome')

name_suffix = ''
version_suffix = ''
app_id_suffix = ''

if get_option('nightly')
  git = find_program('git', required: false)
  hash = ''

  if git.found()
    hash = run_command(git.full_path(), 'rev-parse', '--short', 'HEAD', check: true).stdout().strip()
  endif

  nightly = true
  version_suffix = '.nightly'
  if hash != ''
    version_suffix += '.' + hash
  endif
  name_suffix = ' (Devel)'
  app_id_suffix = '.Devel'
endif

version = meson.project_version() + version_suffix

app_id_relevant = 'org.altlinux.Software' + app_id_suffix
app_name = 'Atomic Control Center' + name_suffix
app_name_classic = 'Atomic Control Center' + name_suffix

homepage = 'https://atomic.alt-gnome.ru/'
bugtracker = 'https://altlinux.space/alt-atomic/atomic-control-center/issues'
help = 'https://alt-gnome.altlinux.team/matrix-to/#/#alt-atomic:alt-gnome.ru'

conf = configuration_data()
conf.set_quoted('APP_NAME', app_name)
conf.set_quoted('APP_NAME_CLASSIC', app_name_classic)
conf.set_quoted('APP_ID', app_id)
conf.set_quoted('APP_ID_RELEVANT', app_id_relevant)
conf.set_quoted('G_LOG_DOMAIN', app_id)
conf.set10('IS_DEVEL', get_option('nightly'))
conf.set_quoted('VERSION', version)
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
