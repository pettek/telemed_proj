class AddFirstNamLastNameToExam < ActiveRecord::Migration
  def change
    add_column :exams, :first_name, :string
    add_column :exams, :last_name, :string
  end
end
