class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["email"] = params["email"]
    @user["password"] = BCrypt::Password.create(params["password"])
    @user.save
    flash[:notice] = "Thanks for signing up! Now login."
    redirect_to "/login"
  end
end

