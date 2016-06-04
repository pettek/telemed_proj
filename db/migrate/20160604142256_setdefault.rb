class Setdefault < ActiveRecord::Migration
  def change
  	change_column_default(:exams, :srate, 1000)
  end
end
