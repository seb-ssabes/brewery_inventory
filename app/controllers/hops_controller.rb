class HopsController < ApplicationController

  def index
  end

  def api_search
    if params[:query].present?
      query = params[:query].downcase
      Rails.logger.info "Query received: #{query}"

      @hops = Hop.where('lower(name) LIKE ?', "#{query}%")
      Rails.logger.info "Hops found: #{@hops.pluck(:name)}"


      hops_data = @hops.map do |hop|
        { name: hop.name }
      end

      Rails.logger.info "Hops found: #{hops_data.pluck(:name)}"
      render json: hops_data, status: :ok
      
    else
      Rails.logger.info "No query parameter provided"
      render json: [], status: :ok
    end
  end
end
