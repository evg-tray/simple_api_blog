class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.datetime :published_at, null: false
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.references :post, null: false

      t.timestamps
    end
  end
end
