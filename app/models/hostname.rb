class Hostname < ApplicationRecord
  has_and_belongs_to_many :dns_records
  validates :value, presence: true
end
