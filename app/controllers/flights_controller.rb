class FlightsController < ApplicationController
  def result
    @seats = params[:seats]

    if params[:date].empty?
      @flights = Flight.by_route(
        params[:departure_id],
        params[:arrival_id]).available
    else
      @flights = Flight.by_route(
        params[:departure_id],
        params[:arrival_id]).
                 by_date(params[:date])
    end

    if @flights.empty?
      flash[:notice] = "No Flights Available For That Search"
      redirect_to root_path
    end
  end

  def all
    @current_page = params[:page].to_i

    @pages = Flight.all.available.length / 10
    @flights = Flight.per_page(params[:page])
  end

  def search
    @airports = Airport.all.order("name ASC")
  end
end
