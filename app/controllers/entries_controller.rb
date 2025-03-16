class EntriesController < ApplicationController
  def new
    @place = Place.find_by({ "id" => params["place_id"] })
    if @place.nil?
      flash["alert"] = "Place not found."
      redirect_to "/places"
      return
    end

    @entry = Entry.new
  end

  def create
    @place = Place.find_by({ "id" => params["place_id"] })
    if @place.nil?
      flash["alert"] = "Place not found."
      redirect_to "/places"
      return
    end

    @entry = @place.entries.new(entry_params)
    @entry["user_id"] = current_user["id"]

    if params["entry"]["uploaded_image"].present?
      @entry.uploaded_image.attach(params["entry"]["uploaded_image"])
    end

    if @entry.save
      flash["notice"] = "Entry added successfully."
      redirect_to place_path(@place["id"])
      return
    else
      flash["alert"] = "Error creating entry."
      render :new
    end
  end

  private

  def entry_params
    params.require("entry").permit("title", "description", "occurred_on", :uploaded_image)  # ✅ Allow uploaded images
  end
end
