class AddCascadeToComments < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :comments, :articles
    add_foreign_key :comments, :articles, on_delete: :cascade
  end
end
