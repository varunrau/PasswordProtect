class Login < ActiveRecord::Base
  attr_accessible :org, :password, :user_id, :user_name
end
