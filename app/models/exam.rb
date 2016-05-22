class Exam < ActiveRecord::Base
	has_many :samples

	def import_samples(filename)
    f = File.open(filename)
    header = f.readline.gsub!(/[^0-9A-Za-z,]/, '').split(",")
    self.patient = header[0]
    self.activity = header[1]

    f.readline
    
    f.readlines.each do |t|
      row = t.split("\t")
      Sample.create(time: row[0], ax: row[1], ay: row[2], az: row[3], exam_id: self.id)
    end

    save!
  end

end
