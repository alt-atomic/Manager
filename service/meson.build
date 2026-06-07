service_vapi_sources = files(
  'config.vapi',
)

service_vala_sources = files(
  'main.vala',
  'root-containers-storage.vala',
  'service.vala',
  'utils.vala',
)

service_dependencies = [
  polkit_dep,
  posix_dep,
]

service_sources = [
  service_vala_sources,
  service_vapi_sources,
]

service_c_args = [

]

service_vala_args = [

]

configure_file(output: 'config.h', configuration: conf)
service_config_h_dir = include_directories('.')

executable(
  app_id,
  service_sources,
  include_directories: service_config_h_dir,
  dependencies: service_dependencies,
  c_args: service_c_args,
  vala_args: service_vala_args,
  install: true,
  install_dir: libexecdir
)

service_sources = meson.current_source_dir()

subdir('data')
