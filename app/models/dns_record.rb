class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames
  validates :ip, presence: true

  PAGE_LIMIT = 5

  def self.by_hostnames(hostnames_required: [], hostnames_ignored: [], page: nil)
    raise "Page is required" unless page.present?

    dns_records = DnsRecord.all # This is not optimized

    if hostnames_required.present?
      dns_records = dns_records.filter { |dns_record| (dns_record.hostnames.map(&:value) & hostnames_required).size == hostnames_required.size }
    end

    if hostnames_ignored.present?
      dns_records = dns_records.filter { |dns_record| (dns_record.hostnames.map(&:value) & hostnames_ignored).empty? }
    end

    dns_records.drop(PAGE_LIMIT * page).first(PAGE_LIMIT)
  end
end
