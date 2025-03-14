class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session["user_id"] = @user["id"]
      flash["notice"] = "Account created!"
      redirect_to "/places"
    else
      flash["notice"] = "Sign-up failed."
      redirect_to "/users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
