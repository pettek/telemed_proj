require 'csv'
require 'zip'

class Exam < ActiveRecord::Base
	has_many :samples, dependent: :destroy
	def import_samples(filename)
    f = File.open(filename)
    header = f.readline.gsub!(/[^0-9A-Za-z,]/, '').split(",")
    self.patient = header[0]
    self.activity = header[1]
    self.first_name = header[2]
    self.last_name = header[3]

    f.readline

    array = []
    f.readlines.each do |t|
      row = t.split("\t")
      if(!(row[0].nil? || row[1].nil? || row[2].nil? || row[3].nil?))
        hash = { :time => row[0], :ax => row[1], :ay => row[2], :az => row[3], :exam_id => self.id }  
        array.push(hash)
      end
    end
    Sample.bulk_insert do |instance|
      array.each do |attrs|
          instance.add(attrs)
      end
    end
    save!
  end

  def to_csv
    filenamecsv = File.new("tmp/samples_#{Time.now}", 'w+')
    CSV.open(filenamecsv, 'wb') do |csv|
      samples.each do |sample|
        csv << [sample.time, sample.ax, sample.ay, sample.az]
      end
    end

    filenamecsv
  end



end

