class EntriesController < ApplicationController

  before_action :require_login, only: [:new, :create]

private

def require_login
  unless session["user_id"]
    redirect_to "/login", alert: "You must be logged in to create an entry."
  end
end

  
  def new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @user["id"]
    @entry.save
    else
      flash[:notice] = "Login first."
    end
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
