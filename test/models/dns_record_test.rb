# frozen_string_literal: true

require "test_helper"

class DnsRecordTest < ActiveSupport::TestCase
  test "that fixtures are valid" do
    assert dns_records.all?(&:valid?)
  end

  test "that mandatory attributes are validated" do
    dns_record = DnsRecord.new
    assert dns_record.invalid?
    assert_equal 1, dns_record.errors.count
    assert_equal ["can't be blank"], dns_record.errors[:ip]
  end

  test "that it returns dns records by hostnames" do
    # Page is required
    assert_raise "Page is required" do
      DnsRecord.by_hostnames
    end

    # Pagination
    assert 5, DnsRecord.by_hostnames(page: 0)
    assert 1, DnsRecord.by_hostnames(page: 1)

    # Hostname required
    assert dns_records(:google), DnsRecord.by_hostnames(hostnames_required: ['google.com'], page: 0)
    assert [], DnsRecord.by_hostnames(hostnames_required: ['google.com'], page: 1)
    assert 3, DnsRecord.by_hostnames(hostnames_required: ['amazon.com'], page: 0)

    # Hostname ignored
    assert dns_records(:amazon), DnsRecord.by_hostnames(hostnames_required: ['amazon.com'],
                                                        hostnames_ignored: ['prime.amazon.com', 'kindle.amazon.com'],
                                                        page: 0)
  end
end
