# -*- coding: utf-8 -*-

require 'fileutils'

module Screenshot

  module_function

  ## Usage:
  # capture_screenshot => #{ screenshot_dir }/img_1.png
  # capture_screenshot(prefix: 'foo') => #{ screenshot_dir}/foo_img_2.png
  def capture_screenshot(prefix: nil)
    img_name = "img_#{ screenshot_count }.png"
    img_name =  "#{ prefix }_#{ img_name }" unless prefix.nil?
    img_path = File.join(screenshot_dir, img_name)
    begin
      $driver.driver.save_screenshot(img_path)
      @@screenshot_count += 1
    rescue => e
      $stderr.puts "saving screenshot failed #{ e.message }"
    end
    img_path
  end

  def screenshot_count
    @@screenshot_count ||= 1
  end

  def screenshot_dir
    @@screenshot_dir ||= File.join(Bundler.root, 'screenshots', Time.now.strftime('%Y%m%d-%H%M%S')).tap do |dirname|
      FileUtils.mkdir_p dirname
    end
  end
end
