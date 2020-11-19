class AddDefaultTimestimeToAssociation < ActiveRecord::Migration[6.0]
  def change
    change_column :dns_records_hostnames, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :dns_records_hostnames, :updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
