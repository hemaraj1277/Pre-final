class UsersController < ApplicationController
 

 before_filter :signed_in_user, only: [:edit, :update, :requestuser]
 before_filter :correct_user,   only: [:edit, :update]
 before_filter :admin_user,     only: :destroy

 private

   

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    
end
public

 def create

    @user = User.new(params[:user])
    if @user.save

    sign_in @user
    flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else	
      render 'new'
    end

  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new

   @user = User.new

  end

  def update

    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user

    else
      render 'edit'
    end

  end


   def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]) 
   
  end

   def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    #flash[:success] = "User destroyed."
    redirect_to @user
  end

   def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

   def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


 def requests

     @title = "Requests"
     @user = User.find(params[:id])
     @users = @user.requesters.paginate(page: params[:page])
    # @user.requests
    
 end

         

  
end
