class AddSearchAuthorName < ActiveRecord::Migration[6.1]
  def change
    enable_extension :pg_trgm
    add_index :authors, :name, opclass: :gin_trgm_ops, using: :gin
  end
end
