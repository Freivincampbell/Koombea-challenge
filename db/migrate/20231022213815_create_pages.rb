class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :link
      t.string :title
      t.string :optional_title
      t.integer :total_links, default: 0
      t.boolean :done, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
