class Login < ActiveRecord::Base
  attr_accessible :password, :user_name
  belongs_to :user
end
