class HopsController < ApplicationController
  before_action :load_hops

  def index
    @hops = Hop.load_hops_data
    Rails.logger.info "All hops loaded: #{@hops.map { |hop| hop[:name] }}"

    # Optional: Print each hop data like in the `edit` method
    @hops.each do |hop|
      Rails.logger.info "Hop: #{hop[:name]}, Aroma: #{hop[:aroma]}, Alpha: #{hop[:alpha]}, Type: #{hop[:hop_type]}, Substitutes: #{hop[:substitutes]}"
    end
  end

  def api_search
    # if
      response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "0"

      # params[:query].present?
      Rails.logger.info "Total hops loaded: #{@hops.size}"
      Rails.logger.info "Hops list: #{@hops.map(&:name).inspect}"

      query = params[:query].to_s.downcase
      Rails.logger.info "Search query (downcased): #{query.downcase}"

      matched_hops = @hops.select { |hop| hop.name.to_s.strip.downcase.include?(query) }

      # @hops = Hop.where('name ILIKE ?', "%#{query}%")

      Rails.logger.info "Hops found: #{@hops.pluck(:name)}"


      hops_data = matched_hops.map do |hop|
        { name: hop.name }
      end

      render json: hops_data, status: :ok
    # else
    #   render json: [], status: :ok
    # end
  end

  def api_detail
    Rails.logger.info "Total hops loaded: #{@hops.size}"
    Rails.logger.info "Hops list: #{@hops.map(&:name).inspect}"
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
