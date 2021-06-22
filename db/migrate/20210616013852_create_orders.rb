class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :receiver_zipcode
      t.string :receiver_address
      t.string :receiver_address_detail
      t.string :receiver_name

      t.timestamps
    end
  end
end
