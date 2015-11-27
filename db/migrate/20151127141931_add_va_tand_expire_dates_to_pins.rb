class AddVaTandExpireDatesToPins < ActiveRecord::Migration
  def change
    add_column :pins, :offer_expirey_date, :date
    add_column :pins, :invoice_VAT, :decimal
    add_column :pins, :gross_invoice_amount, :decimal
  end
end
