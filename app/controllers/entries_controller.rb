class EntriesController < ApplicationController
  before_action :authenticate_user

  def index
    @entries = Entry.all.order(created_at: :desc) || []  # Ensure it's never nil
  end

  def new
    @entry = Entry.new
  end

  def create
    if params[:entry].nil?
      flash["notice"] = "Something went wrong. Entry data is missing."
      redirect_to "/entries"
      return
    end

    # Find or create the place based on the inputted name
    place_name = params[:entry][:place_name]
    place = Place.find_by(name: place_name) || Place.create(name: place_name, user_id: session["user_id"])

    # Create the entry and assign the place
    @entry = Entry.new(entry_params)
    @entry.user_id = session["user_id"]
    @entry.place_id = place.id

    if @entry.save
      flash["notice"] = "Entry created!"
      redirect_to "/entries"
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
    params.require(:entry).permit(:body, :uploaded_image)
  end
end
