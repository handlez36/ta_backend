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

require 'test_helper'

class JourneyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
