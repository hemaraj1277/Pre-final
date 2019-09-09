# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class User < ActiveRecord::Base


  attr_accessible :email, :name, :password, :password_confirmation, :id
  has_secure_password
  has_many :microposts, dependent: :destroy



  has_many :relationships, foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower


  has_many :reverse_relationships, foreign_key: "follower_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followed_users, through: :reverse_relationships, source: :followed




  
  has_many :reverse_requests, foreign_key: "requested_id", class_name:  "Request", dependent: :destroy
  has_many :requesters, through: :reverse_requests, source: :requester

  has_many :requests, foreign_key: "requester_id", dependent: :destroy
                                 
                                  
  has_many :requested_users, through: :requests, source: :requested 



   validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

   validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false } 

   validates :password, presence: true, length: { minimum: 6 } 

   validates :password_confirmation, presence: true 

   before_save { |user| user.email = email.downcase }

   before_save :create_remember_token

   before_create { generate_token(:auth_token) }

   private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_token(column)
    
    begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end
 


  
 public
  def following?(other_user)
    other_user.relationships.find_by_follower_id(self.id)
  end

  def follow!(other_user)
    relationships.create!(follower_id: other_user.id)
    other_user.requests.find_by_requested_id(self.id).destroy

  end

 def unfollow!(other_user)
   other_user.relationships.find_by_follower_id(self.id).destroy
  end
  
 def request!(other_user, status)

      requests.create!(requested_id: other_user.id, status: status)

end

def update!(other_user, status)
     
     self.requests.update!(requested_id: other_user.id)
 
  end

def req_pending

      requests.find_by_status(2)
end

def decline!(other_user)

  other_user.requests.find_by_requested_id(self.id).destroy

end

def hasrequest?(other_user)

     requests.find_by_requested_id(other_user.id)

end

def cancel!(other_user)

self.requests.find_by_requested_id(other_user.id).destroy

end

def send_password_reset


  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!(validate: false)
  ResetPassword.perform_async(self.name, self.email, self.password_reset_token)

end


end