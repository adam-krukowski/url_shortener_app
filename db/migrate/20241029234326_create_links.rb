class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :slug
      t.integer :clicked

      t.timestamps
    end
  end
end
