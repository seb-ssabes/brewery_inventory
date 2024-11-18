class HopsController < ApplicationController
  before_action :load_hops

  def index
    @hops = Hop.load_hops_data
  end

  def api_search
    if params[:query].present?
      @hops = Hop.load_hops_data
      Rails.logger.info "Total hops loaded: #{@hops.size}"

      query = params[:query].to_s.downcase

      matched_hops = @hops.select { |hop| hop[:name].to_s.strip.downcase.starts_with?(query) }

      # Rails.logger.info "Matched hops: #{matched_hops.map { |hop| hop[:name] }}"

      hops_data = matched_hops.map do |hop|
        { name: hop[:name] }
      end

      render json: hops_data, status: :ok
    else
      render json: [], status: :ok
    end
  end

  def api_detail
    hop_name = params[:name].to_s.strip.downcase
    @hops = Hop.load_hops_data

    selected_hop = @hops.find { |hop| hop[:name]&.strip&.downcase == hop_name }

    if selected_hop
      hop_data = {
        name: selected_hop[:name],
        aroma: selected_hop[:aroma],
        alpha: selected_hop[:alpha],
        hop_type: selected_hop[:hop_type],
        substitutes: selected_hop[:substitutes]
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
