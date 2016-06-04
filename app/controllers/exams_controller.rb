class ExamsController < ApplicationController

	def list
      @exams = Exam.all
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
      start_time = Time.now

      if @exam.save

         params[:exam][:attachment].each do |attachment|
            filepath = attachment.tempfile.path            
            @exam.import_samples(filepath)
            @exam = Exam.create
         end
         end_time = Time.now
         flash[:success] = "Czas zapisu w sekundach: " + (end_time - start_time).to_s
         redirect_to :action => 'list'
         Exam.last.destroy
      else
         render :action => 'new'
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
   
   def delete
      if params[:deleteRecord].present?
         params[:deleteRecord].each do |id|
            Exam.find(id).destroy
         end
      end
      redirect_to :action => 'list'
   end
end
