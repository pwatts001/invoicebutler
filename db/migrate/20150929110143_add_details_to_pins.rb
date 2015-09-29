class AddDetailsToPins < ActiveRecord::Migration
  def change
    add_column :pins, :ref, :string
    add_column :pins, :suppler_ref, :string
    add_column :pins, :suppler_name, :string
    add_column :pins, :string, :string
    add_column :pins, :invoice_number, :string
    add_column :pins, :invoice_date, :date
    add_column :pins, :due_date, :date
    add_column :pins, :invoice_amount, :decimal
    add_column :pins, :invoice_curr, :string
    add_column :pins, :status, :string
    add_index :pins, :status
    add_column :pins, :prop_settlement_date, :date
    add_column :pins, :offer_amount, :decimal
    add_column :pins, :saving, :decimal
  end
end
