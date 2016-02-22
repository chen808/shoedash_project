class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product
      t.string :seller
      t.float :amount
      t.boolean :sold, :default => false
      t.string :buyer

      t.timestamps
    end
  end
end
