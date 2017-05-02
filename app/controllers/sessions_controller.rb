class SessionsController < ApplicationController
  def new
  end

	def create
	  auth_hash = request.env['omniauth.auth']
	 
	  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	  if @authorization
	    @user = User.find_by_email(@authorization.user.email)
	    session[:user] = @user
	    binding.pry
	    redirect_to "/welcome/landing"
	  else
	    user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
	    user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	    user.save
	 
	    render "/welcome/landing"
	  end
	end

  def failure
  end

  def destroy
	  session[:user_id] = nil
	  session[:user] = nil
	  redirect_to "/welcome/landing"
	end

end
