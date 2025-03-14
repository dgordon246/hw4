class EntriesController < ApplicationController
  before_action :authenticate_user

  def create
    if params[:entry].nil?
      flash["notice"] = "Something went wrong. Entry data is missing."
      redirect_to "/entries"
      return
    end

    @entry = Entry.new(entry_params)
    @entry.user_id = session["user_id"]

    if @entry.save
      flash["notice"] = "Entry created!"
    else
      flash["notice"] = "Something went wrong!"
    end

    redirect_to "/entries"
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
