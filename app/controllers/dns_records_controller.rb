class DnsRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if DnsRecord.exists?(ip: params[:ip])
      render json: { error: 'DNS record already exists' }, status: 400
    elsif !params[:ip].present? || !params[:hostnames].present?
      render json: { error: 'IP and hostnames are required'}, status: 400
    else
      dns_record = DnsRecord.create! ip: params[:ip]
      hostnames = params[:hostnames].map { |hostname| Hostname.find_or_create_by(value: hostname) }
      dns_record.hostnames << hostnames
      render json: { id: dns_record.id }
    end
  end
end
