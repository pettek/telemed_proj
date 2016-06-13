class ExamsController < ApplicationController
   

   def list
      @exams = Exam.where(filter_params)
   end

   def filter_params
      params[:filter] ||= {}
      params[:filter].permit(:activity, :first_name, :patient, :last_name).reject { |k, v| v.empty? }
   end

   def show
      @exam = Exam.find(params[:id])
   end
  
   def new
      @exam = Exam.new
   end

   def exam_params
      params.require(:exam).permit(:activity, :patient, :srate, :date)
   end

   def create
      @exam = Exam.new(exam_params)
      idArray = Array.new
      start_time = Time.now

      begin
         if @exam.save

            params[:exam][:attachment].each do |attachment|
               filepath = attachment.tempfile.path
               idArray.push(@exam.id)
               @exam.import_samples(filepath)
               @exam = Exam.create
            end
            end_time = Time.now
            flash[:success] = "Czas zapisu w sekundach: " + (end_time - start_time).to_s
            redirect_to :action => 'list'
            Exam.last.destroy
         end
      rescue
         idArray.each do |id|
            exam = Exam.find(id)
            exam.samples.delete_all
            exam.destroy
         end
         redirect_to :action => 'new', :error => 'true'
      end
   end
   
   def edit
      @exam = Exam.find(params[:id])
   end
   
   def exam_param
      params.require(:exam).permit(:activity, :patient, :first_name, :last_name)
   end
   
   def update
      @exam = Exam.find(params[:id])
      
      if @exam.update_attributes(exam_param)
         redirect_to :action => 'show', :id => @exam
      else
         render :action => 'edit'
      end
   end
   
   require 'csv'

   def delete
      start_time = Time.now
      if params[:deleteRecord].present?
         if params[:download]

            # prepare zip file
            filename="exams_#{Date.today}.zip"
            temp_file = Tempfile.new(filename)

            Zip::OutputStream.open(temp_file) { |zos| }

            # add files to zip
            Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
               params[:deleteRecord].each do |id|
                  out = Exam.find(id)
                  zip.add("exam_#{id}.csv", out.to_csv)
               end    

            end

            # send to user
            # send_data ten_twoj_zip, filename: "examsout-#{Exam.id}.csv"
            zip_data = File.read(temp_file.path)
            send_data(zip_data, :type => 'application/zip', :filename => filename)

         else
            params[:deleteRecord].each do |id|
               exam = Exam.find(id)
               exam.samples.delete_all
               exam.destroy
         
               end_time = Time.now
               flash[:success] = "Czas usunięcia w sekundach: " + (end_time - start_time).to_s
               redirect_to :action => 'list'
            end
         end
      end
   end
end
   

   # def csv_export

   #    if params[:deleteRecord].present?
   #       params[:deleteRecord].each do |id|
   #          out = Exam.find(id)
   #          respond_to do |format|
   #             format.html
   #             format.csv { send_data out.to_csv, filename: "examout-#{Date.today}.csv" }
   #          end
   #       end
   #    end
   # end
