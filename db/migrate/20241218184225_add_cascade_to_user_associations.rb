class AddCascadeToUserAssociations < ActiveRecord::Migration[8.0]
  def change
    def change
      remove_foreign_key :comments, :users
      add_foreign_key :comments, :users, on_delete: :cascade
  
      remove_foreign_key :articles, :users
      add_foreign_key :articles, :users, on_delete: :cascade
    end
  end
end
