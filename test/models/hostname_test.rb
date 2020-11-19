# frozen_string_literal: true

require "test_helper"

class HostnameTest < ActiveSupport::TestCase
  test "that fixtures are valid" do
    assert hostnames.all?(&:valid?)
  end

  test "that mandatory attributes are validated" do
    hostname = Hostname.new
    assert hostname.invalid?
    assert_equal 1, hostname.errors.count
    assert_equal ["can't be blank"], hostname.errors[:value]
  end
end
