class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] }) 

    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"].to_s
        session["user_id"] = @user["id"]
        flash["notice"] = "Hello."
        redirect_to "/places"
      else
        flash["notice"] = "Invalid password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Invalid email"
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
