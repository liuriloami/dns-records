# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

class DnsRecordsControllerTest < ActionDispatch::IntegrationTest
  test 'that page is required' do
    get dns_records_path
    assert_response :bad_request
    assert 'Page is required', response[:error]
  end

  test 'that 5 DNS records and their hostnames are returned if no filters' do
    get dns_records_path, params: { page: 0 }
    assert_response :ok
    assert 5, response['total']
    assert 5, response['dns_records'].size
    assert 3, response['hostnames'].size
  end

  test 'that only google record is returned' do
    get dns_records_path, params: { page: 0, hostnames_required: ['google.com'] }
    assert_response :ok
    assert 1, response['total']
    assert  '1.1.1.1', response['dns_records'].first['ip']
    assert 'google.com', response['hostnames'].first['value']
    assert 1, response['hostnames'].first['matches']
  end

  test 'that a DNS record and its hostnames are created' do
    post dns_records_path, params: { ip: '1.2.3.4', hostnames: ['youtube.com', 'vimeo.com'] }
    assert_response :ok
    assert response['id']

    dns_record = DnsRecord.find(response['id'])
    assert '1.2.3.4', dns_record.ip
    assert ['youtube.com', 'vimeo.com'], dns_record.hostnames.map(&:value)
  end

  private
  def response
    ActiveSupport::JSON.decode @response.body
  end
end
