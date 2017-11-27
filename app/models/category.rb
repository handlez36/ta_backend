# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base  
  has_many :journys, class_name: 'Journey', dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
