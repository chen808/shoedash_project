class CreateBuys < ActiveRecord::Migration
  def change
    create_table :buys do |t|
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
