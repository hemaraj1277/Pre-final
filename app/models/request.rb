class Request < ActiveRecord::Base
  attr_accessible :requested_id, :requester_id, :status


belongs_to :requester, class_name: "User"
belongs_to :requested, class_name: "User"

end
