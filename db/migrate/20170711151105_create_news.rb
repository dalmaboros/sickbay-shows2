class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :date
      t.string :content

      t.timestamps null: false
    end
  end
end
