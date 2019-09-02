class RequestsController < ApplicationController

before_filter :signed_in_user


=begin
def create
  @request = Request.new(request_params)

  if @request.save
      flash[:success] = "Follow invitation sent!"
      redirect_to users_path
  else
     flash[:error] = "Errors. Couldn't send follow request"
     render view_name
  end
end
=end

def create
    @user = User.find(params[:request][:requested_id])
    current_user.request!(@user)
    #current_user.status=2
      respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end


=begin
def show

end


def create
  @request = Request.find(params[:id])

  @request.assign_attributes(request_params)

  if @request.accepted_at_changed?
  
   flash[:success] = "You've accepted the follow request"
  end

  if @request.declined_at_changed?
   
   flash[:error] = "You've declined the follow request"
  end

  if @request.save
   redirect_to users_path
  else
   redirect_to root_path, alert: 'Not updated follow request!'
  end
end

private

def request_params
  params.require(:request).permit(:sender_id, :sending_id, :accepted_at, :declined_at)
end

=end


end