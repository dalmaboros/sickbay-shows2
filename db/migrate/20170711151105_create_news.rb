class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :date
      t.string :content
      t.string :url

      t.timestamps null: false
    end
  end
end
