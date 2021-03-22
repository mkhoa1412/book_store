class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.belongs_to :author, foreign_key: true, index: true
      t.string :title, null: false
      t.monetize :price
      t.timestamps
    end
  end
end
