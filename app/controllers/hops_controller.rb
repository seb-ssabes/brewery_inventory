class HopsController < ApplicationController
  before_action :load_hops, only: [:api_detail]

  # def index

  # end

  def api_search
    if params[:query].present?
      query = params[:query].downcase

      @hops = Hop.where('lower(name) LIKE ?', "#{query}%")

      hops_data = @hops.map do |hop|
        { name: hop.name }
      end

      render json: hops_data, status: :ok
    else
      render json: [], status: :ok
    end
  end

  def api_detail
    # Retrieve the name parameter from the request (e.g., api_detail?name=Cascade).
    hop_name = params[:name].to_s.strip.downcase

    selected_hop = @hops.find { |hop| hop.name&.strip&.downcase == hop_name }

    if selected_hop
      hop_data = {
        name: selected_hop.name,
        aroma: selected_hop.aroma,
        alpha: selected_hop.alpha,
        hop_type: selected_hop.hop_type,
        substitutes: selected_hop.substitutes
      }
      render json: hop_data, status: :ok
    else
      render json: { error: "Hop not found" }, status: :not_found
    end
  end

  def load_hops
    @hops = Hop.all
  end
end
