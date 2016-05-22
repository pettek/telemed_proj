class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :time
      t.integer :ax
      t.integer :ay
      t.integer :az
      t.references :exam, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
