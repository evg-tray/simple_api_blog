class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
