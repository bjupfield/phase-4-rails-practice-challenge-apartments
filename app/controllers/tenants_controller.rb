class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessed
    def show
        c = Tenant.find(params[:id])
        render json: c
    end
    
    def index
        c = Tenant.all
        render json: c
    end

    def create
        c = Tenant.create!(apartment_params)
        render json: c, status: :created
    end

    def update
        c = Tenant.find(params[:id])
        c.update(apartment_params)
        render json: c
    end

    def destroy
        c = Tenant.find(params[:id])
        c.destroy
        head :no_content
    end

    private

    def apartment_params 
        params.permit(:name, :age)
    end
    def render_unprocessed(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
    def render_not_found
        render json: { error: "Tenant not Found"}, status: :not_found
    end
end
