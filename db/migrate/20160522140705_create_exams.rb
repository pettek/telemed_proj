class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :activity
      t.string :patient
      t.float :srate
      t.datetime :date
      t.timestamp :created
      t.timestamps null: false
    end
  end
end
