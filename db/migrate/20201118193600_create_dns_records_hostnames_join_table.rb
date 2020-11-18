class CreateDnsRecordsHostnamesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :dns_records, :hostnames do |t|
      t.index :dns_record_id
      t.index :hostname_id
      t.timestamps
    end
  end
end
