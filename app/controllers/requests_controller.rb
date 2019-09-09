class RequestsController < ApplicationController

before_filter :signed_in_user



def create
    @user = User.find(params[:request][:requested_id])
    current_user.request!(@user, 2)
   
      respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end


def update


 end 


def destroy


@user = Request.find(params[:id]).requester
    current_user.decline!(@user)
     respond_to do |format|
      format.html { redirect_to current_user }
      format.js
      end


end


def cancel
 
 
 @user = User.find(params[:id])
     current_user.cancel!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
      end



end  





end