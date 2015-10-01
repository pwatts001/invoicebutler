class AddMoreDetailsToPins < ActiveRecord::Migration
  def change
    add_column :pins, :supplier_email, :string
    add_column :pins, :offer_sent_date, :date
    add_column :pins, :offer_accepted_date, :date
  end
end
