class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessed
    def show
        c = Apartment.find(params[:id])
        render json: c
    end
    
    def index
        c = Apartment.all
        render json: c
    end

    def create
        c = Apartment.create!(apartment_params)
        render json: c, status: :created
    end

    def update
        c = Apartment.find(params[:id])
        c.update(apartment_params)
        render json: c
    end

    def destroy
        c = Apartment.find(params[:id])
        c.destroy
        head :no_content
    end

    private

    def apartment_params 
        params.permit(:number)
    end
    def render_unprocessed(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
    def render_not_found
        render json: { error: "Apartment not Found"}, status: :not_found
    end
end
