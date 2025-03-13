class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["email"] = params["email"]
    @user["password"] = BCrypt::Password.create(params["password"])
    if @user.save
      flash[:notice] = "Thanks for signing up! Now login."
      redirect_to "/login"
    else
      flash[:notice] = "Error signing up."
      render "new"
    end
  end
end
