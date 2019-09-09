class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:follower_id])
   current_user.follow!(@user)   

   NotifyUsers.perform_async(@user.email)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end


  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
     respond_to do |format|
      format.html { redirect_to @user }
      format.js
      end
  end

  


end