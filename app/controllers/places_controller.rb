class PlacesController < ApplicationController
  before_action :authenticate_user

  def index
    @places = Place.where(user_id: session["user_id"])
  end

  def show
    @place = Place.find_by({ "id" => params["id"], "user_id" => session["user_id"] })
    @entries = Entry.where({ "place_id" => @place.id, "user_id" => session["user_id"] })
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place["user_id"] = session["user_id"]
    @place.save
    redirect_to "/places"
  end

  private

  def authenticate_user
    unless session["user_id"]
      flash["notice"] = "You must log in first."
      redirect_to "/login"
    end
  end

end
