#User controller class for user creation.
class UserController < ApplicationController
#Creates a new user and places it in the @user class variable.
  def new
    @user = User.new
  end
#create saves a new user to the database (unless validation fails or information is missing) and returns
#"you signed up successfully", or, "Form is invalid" depending upon input.
  def create
    @user = User.new(params.require(:user).permit(:username, :password, :fname, :lname, :salt, :email, :password_confirmation))
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end
end
