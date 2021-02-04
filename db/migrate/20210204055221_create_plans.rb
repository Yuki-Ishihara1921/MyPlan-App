class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.date :start
      t.date :end
      t.string :days
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
