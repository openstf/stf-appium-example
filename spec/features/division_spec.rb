# -*- coding: utf-8 -*-

RSpec.describe 'Calculator' do
  let!(:x) { 7 }
  let!(:y) { 3 }

  context 'division' do
    before do
      $driver.find_element(:accessibility_id, 'resetButton').click

      sleep 1
      $driver.find_element(:accessibility_id, 'inputFieldLeft').send_key(x)
      $driver.find_element(:accessibility_id, 'inputFieldRight').send_key(y)

      sleep 1
    end

    after do |example|
      if example.exception
        example.metadata[:failed_screenshot] = Screenshot.capture_screenshot
      end
    end

    it 'divide two numbers' do
      $driver.find_element(:accessibility_id, 'divisionButton').click
      sleep 1

      result_text = $driver.find_element(:accessibility_id, 'resultTextView').text
      expected_result = "%.2f" % x + " / " + "%.2f" % y + " = " + "%.2f" % (x.to_f / y.to_f)
      expect(result_text).to eq(expected_result)
    end
  end
end
