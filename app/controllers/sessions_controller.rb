class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] }) 

    if @user != nil
      begin
        if BCrypt::Password.new(@user["password"]) == params["password"]
          session["user_id"] = @user["id"]
          flash["notice"] = "Hello."
          redirect_to "/places"
        else
          flash["notice"] = "Nope."
          redirect_to "/login"
        end
      rescue BCrypt::Errors::InvalidHash
        @user["password"] = BCrypt::Password.create(params["password"])
        @user.save
        session["user_id"] = @user["id"]
        flash["notice"] = "Password updated. You are now logged in."
        redirect_to "/places"
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
