class CalculatorsController < ApplicationController
  def index
  end

  def abv
  end

  def density_correction
  end

  def calculate_abv
    og = params[:og].to_f
    fg = params[:fg].to_f

    abv = (og - fg) * 131.25
    render json: { abv: abv.round(2) }
  end

  def calculate_density_correction
    measured_density = params[:measured_density]
    current_temp = params[:current_temp].to_f
    densimeter_temp = params[:densimeter_temp].to_f

    corrected_density = measured_density + (0.00025 * (current_temp - densimeter_temp))

    render json: { corrected_density: format('%.3f', corrected_density) }
  end
end
