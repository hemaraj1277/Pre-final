class Request < ActiveRecord::Base
  attr_accessible :accepted_at, :declined_at

belongs_to :follower, class_name: "User", foreign_key: "follower_id" 

belongs_to :followed, class_name: "User", foreign_key: "followed_id" 

end
