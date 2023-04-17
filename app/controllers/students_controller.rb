class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable
    
        def index
        students = Student.all 
        render json: students
        end
    
        def show
        student = Student.find(params[:id])
        render json: student
        end
    
        def create
            student = Student.create!(student_params)
        render json: student, include: :instructor, status: :created
        end
    
        def update
            student = Student.find(params[:id])
            student.update!(student_params)
        render json: student, include: :instructor, status: :updated
        end
    
        def destroy
            student = Student.find(params[:id])
            student.destroy
        render json: student
        end
    
        private
    
        def student_params
            params.permit(:name, :age, :major)
        end
    
        def render_not_found
            render json: {error: "Student not found"}, status: :not_found
        end
    
        def render_unprocessable(invalid)
            render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
    end
    
