class DnsRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  PAGE_LIMIT = 10

  def index
    hostnames_required = params[:hostnames_required]
    hostnames_ignored = params[:hostnames_ignored] || []
    page = params[:page]

    if !page
      render json: { error: 'Page is required' }, status: 400
    else
      dns_records = DnsRecord.by_hostnames(hostnames_required: hostnames_required, hostnames_ignored: hostnames_ignored, page: page.to_i)
      hostnames = dns_records.map(&:hostnames).flatten.uniq

      render json: {
          total: dns_records.size,
          dns_records: dns_records.map { |dns_record| dns_record.slice(:id, :ip) },
          hostnames: hostnames.map { |hostname| { value: hostname.value, matches: (hostname.dns_records & dns_records ).size } }
      }
    end
  end

  def create
    ip = params[:ip]
    hostnames = params[:hostnames]

    if !ip.present? || !hostnames.present?
      render json: { error: 'IP and hostnames are required'}, status: 400
    elsif DnsRecord.exists?(ip: ip)
      render json: { error: 'DNS record already exists' }, status: 400
    else
      dns_record = DnsRecord.create! ip: ip
      dns_record.hostnames << hostnames.map { |hostname| Hostname.find_or_create_by(value: hostname) }
      render json: { id: dns_record.id }
    end
  end
end
