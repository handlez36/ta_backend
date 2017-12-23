class User < ActiveRecord::Base
  belongs_to :journey
  
  validates :user_id, presence: true
end
