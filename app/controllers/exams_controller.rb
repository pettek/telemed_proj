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
      params.require(:exams).permit(:activity, :patient, :srate, :date)
   end

   def create
      @exam = Exam.new(exam_params)



      if @exam.save

         @exam.import_samples("DANE.txt")
         redirect_to :action => 'list'

      else
         render :action => 'new'
      end
   end
   
   def edit
      @exam = Exam.find(params[:id])
   end
   
   def exam_param
      params.require(:exam).permit(:activity, :patient, :srate, :date)
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
      Exam.find(params[:id]).destroy
      redirect_to :action => 'list'
   end
end
