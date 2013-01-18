class Login < ActiveRecord::Base
  attr_accessible :password, :user_name, :org
  belongs_to :user
end
