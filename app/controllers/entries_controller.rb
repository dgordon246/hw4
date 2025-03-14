class EntriesController < ApplicationController
  before_action :authenticate_user

  def new
    @place = Place.find_by(id: params[:place_id], user_id: session["user_id"])
    if @place.nil?
      flash["notice"] = "You must select a place first."
      redirect_to "/places"
    else
      @entry = Entry.new
    end
  end

  def create
    @place = Place.find_by(id: params[:place_id], user_id: session["user_id"])
    if @place.nil?
      flash["notice"] = "You must select a place first."
      redirect_to "/places"
      return
    end

    @entry = Entry.new(entry_params)
    @entry.user_id = session["user_id"]
    @entry.place_id = @place.id

    if @entry.save
      flash["notice"] = "Entry created!"
      redirect_to place_path(@entry.place)
    else
      flash["notice"] = "Something went wrong!"
      render "new"
    end
  end

  private

  def authenticate_user
    unless session["user_id"]
      flash["notice"] = "You must log in first."
      redirect_to "/login"
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :uploaded_image)
  end
end
