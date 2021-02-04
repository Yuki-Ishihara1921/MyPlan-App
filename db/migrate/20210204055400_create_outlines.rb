class CreateOutlines < ActiveRecord::Migration[6.0]
  def change
    create_table :outlines do |t|
      t.string :date
      t.string :time
      t.text :schedule
      t.text :note
      t.integer :sort
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
