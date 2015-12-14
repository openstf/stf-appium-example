require 'rspec/core/formatters/html_formatter'
require 'base64'

require_relative '../screenshot'

class ScreenshotEmbeddedHtmlFormatter < RSpec::Core::Formatters::HtmlFormatter

  RSpec::Core::Formatters.register self

  include ::Screenshot

  def extra_failure_content(failure)
    screenshot_path = failure.example.metadata[:failed_screenshot]

    if screenshot_path && File.exist?(screenshot_path)
      content = ''
      content << '<span>'
      content << "<img src='data:image/png;base64,#{ get_encoded_image(screenshot_path) }' height='400' width='200'>"
      content << '</span>'
      super + content
    else
      super
    end
  end

  private

  def get_encoded_image(path)
    Base64.encode64(File.read(path))
  end
end
