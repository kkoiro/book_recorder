class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn, :null => false
      t.string :title
      t.string :author
      t.string :manufacturer
      t.string :image
      t.integer :user_id, :null => false, :index => true

      t.timestamps
    end
  end
end
