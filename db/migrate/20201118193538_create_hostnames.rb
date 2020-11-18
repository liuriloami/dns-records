class CreateHostnames < ActiveRecord::Migration[6.0]
  def change
    create_table :hostnames do |t|
      t.string :value, null: false
      t.timestamps
    end
  end
end
