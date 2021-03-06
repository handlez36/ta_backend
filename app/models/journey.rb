# == Schema Information
#
# Table name: journeys
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Journey < ActiveRecord::Base
  belongs_to :category
  has_many :posts
  
  validates :title, presence: true
  validates :category, presence: true
  validates :user_id, presence: true
end
