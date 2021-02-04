class CreateDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :details do |t|
      t.string :date
      t.time :time
      t.text :schedule
      t.text :note
      t.integer :sort
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
