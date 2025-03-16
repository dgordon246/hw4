class EntriesController < ApplicationController
  def new
    if current_user.nil?
      flash["alert"] = "You must be logged in to create an entry."
      redirect_to "/login"
      return
    end

    @place = Place.find_by({ "id" => params["place_id"] })
    @entry = Entry.new
  end

  def create
    if current_user.nil?  
      flash["alert"] = "You must be logged in to create an entry."
      redirect_to "/login"
      return
    end

    @place = Place.find_by({ "id" => params["place_id"] })
    @entry = @place.entries.new(entry_params)
    @entry["user_id"] = current_user["id"]

    if @entry.save
      flash["notice"] = "Entry added successfully."
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  private

  def entry_params
    params.require("entry").permit("title", "description", "occurred_on", "image")
  end
end
