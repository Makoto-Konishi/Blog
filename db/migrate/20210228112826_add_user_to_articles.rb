class AddUserToArticles < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM articles;'
    add_reference :articles, :user, null: false, index: true
  end
  def down
    remove_reference :articles, :user, index: true
  end
end
