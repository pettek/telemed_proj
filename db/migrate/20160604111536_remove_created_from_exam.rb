class RemoveCreatedFromExam < ActiveRecord::Migration
  def change
    remove_column :exams, :created, :datetime
  end
end
