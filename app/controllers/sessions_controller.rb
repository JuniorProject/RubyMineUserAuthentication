###########################################################################################################################
#Author: Johnathan Leuthold
#Date: 11-26-2014
#Modifications: 
#Description: The Sessions controller class holds temporary user attributes across multiple views with a session object.
###########################################################################################################################

#Sessions controller for managing persistent user information (user database ID and username)
class SessionsController < ApplicationController
  #before_filter is a callback that performs the method immediately following the callback name in the conditions
  #specified, for these two, except means not to fire authenticate_user if those are the methods in the [] that fired.
  #only causes save_login_state to fire only when the methods in [] are fired.
  before_filter :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
  before_filter :save_login_state, :only => [:index, :login, :login_attempt]
  
  ###########################################################################################################################
  #The following four are not yet fleshed out but act as method containers for their respective views.
  ###########################################################################################################################
  def home
#Home Page
  end
  def profile
#Profile Page
  end
  def setting
#Setting Page
  end
  def login
#Login Form
  end
  
  ###########################################################################################################################
  #login_attempt method calls the authenticate method for the User model and if a User is returned
  #welcomes the user back to the website, else it will inform them of an invalid password or username entry.
  ###########################################################################################################################
  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome #{authorized_user.username}"
      redirect_to(:action => 'home')
    else
      flash.now[:notice] = "Invalid Username or Password"
      #Render login regenerates the login view in the current page.
      render "login"
    end
  end
  
  ###########################################################################################################################
  #logout method simply sets the current session type user_id to nil and redircts the user to the login form.
  ###########################################################################################################################
  def logout
    session[:user_id] = nil
    #Redirect actually changes pages vs render, which does not change the page.
    redirect_to :action => 'login'
  end
end
