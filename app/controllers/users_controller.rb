class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["email"] = params[:user][:email]  # FIXED: Correctly access email from params
    @user["password"] = BCrypt::Password.create(params[:user][:password])  # FIXED: Encrypt password before saving

    if @user.save
      flash[:notice] = "Thanks for signing up. Now login."
      redirect_to "/login"
    else
      flash[:alert] = "Error creating account. Please try again."
      render :new
    end
  end
end
