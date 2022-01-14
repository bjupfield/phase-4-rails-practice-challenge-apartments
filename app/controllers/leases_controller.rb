class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessed
    def create
        Apartment.find(lease_params[:apartment_id])
        Tenant.find(lease_params[:tenant_id])
        c = Lease.create!(lease_params)
        render json: c, status: :created
    end

    def destroy
        c = Lease.find(params[:id])
        c.destroy
        head :no_content
    end
    private
    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end
    def render_unprocessed(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
    def render_not_found(invalid)
        render json: { error: invalid}, status: :not_found
    end
end
