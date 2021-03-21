class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.text :name, null: false
      t.timestamps
    end
  end
end
