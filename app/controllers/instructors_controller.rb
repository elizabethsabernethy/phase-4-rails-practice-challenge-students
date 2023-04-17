class InstructorsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable

    def index
    instructors = Instructor.all 
    render json: instructors
    end

    def show
    instructor = Instructor.find(params[:id])
    render json: instructor
    end

    def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
    end

    def update
    instructor = Instructor.find(params[:id])
    instructor.update!(instructor_params)
    render json: instructor, status: :updated
    end

    def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    render json: instructor
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def render_unprocessable(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
