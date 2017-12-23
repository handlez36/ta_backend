class Post < ActiveRecord::Base
  belongs_to :journy, class_name: 'Journey'
end
