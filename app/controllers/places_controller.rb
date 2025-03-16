class PlacesController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]

  def index
    if session["user_id"].nil?
      flash["alert"] = "You must be logged in to view places."
      redirect_to "/login"
      return
    end
  
    @places = Place.where("user_id" => session["user_id"])
  end
  

  def show
    @place = Place.find_by({ "id" => params["id"], "user_id" => session["user_id"] })
    @entries = Entry.where({ "place_id" => @place.id, "user_id" => session["user_id"] })
  end

  def new
    if session["user_id"].nil?
      flash["alert"] = "You must be logged in to add a place."
      redirect_to "/login"
      return
    end
  
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
