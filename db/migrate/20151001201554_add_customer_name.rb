class AddCustomerName < ActiveRecord::Migration
  def change
  	add_column :pins, :customer_name, :string
  end
end
