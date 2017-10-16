class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, uniqueness: true, presence: true

   def self.from_auth_hash(provider, auth_hash)
     user = User.new
     user[:username] = auth_hash['info']['nickname']
     user[:email] = auth_hash['info']['email']
     user[:provider] = auth_hash['provider']
     user[:uid] = auth_hash['uid']
     return user
 #     user = new
 # +    user.provider = provider
 # +    user.uid = auth_hash['uid']
 # +    user.name = auth_hash['info']['name']
 # +    user.email = auth_hash['info']['email']
 # +    user.username = auth_hash['info']['nickname']

   end
end
