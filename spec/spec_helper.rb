# -*- coding: utf-8 -*-

require 'appium_lib'


# support files
SPEC_ROOT = File.expand_path(File.dirname(__FILE__))
Dir[File.expand_path('support/**/*.rb', SPEC_ROOT)].each { |f| require f }

app_path = ENV['APP_PATH'] || raise('please specify application binary path by setting ENV["APP_PATH"]')
udid = ENV['DEVICE_UDID'] || raise('please specify device serial by setting ENV["DEVICE_UDID"]')
appium_port = ENV['APPIUM_PORT'] || '4723'

include ::ServerManager

RSpec.configure do |config|

  config.include ::Screenshot

  config.before(:suite) do
    ServerManager.appium_configuration do |conf|
      conf.port = appium_port
      conf.server_flags = %i(full-reset)
    end

    ServerManager.start_appium_server

    driver_caps = {
      platformName: :android,
      deviceName: '',
      newCommandTimeout: '9999',
      app: File.expand_path(app_path),
      udid: udid
    }

    appium_lib_opts = {
      port: appium_port
    }

    Appium::Driver.new({appium_lib: appium_lib_opts, caps: driver_caps}).start_driver
  end

  config.after(:suite) do
    $driver.driver_quit
    ServerManager.kill_appium_server
  end
end
