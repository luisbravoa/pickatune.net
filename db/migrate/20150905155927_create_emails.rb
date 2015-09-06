class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string "email", :limit => 254, :null => false, :unique => true
      t.timestamps null: false
    end
  end
end
