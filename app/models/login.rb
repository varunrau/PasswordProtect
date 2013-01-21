class Login < ActiveRecord::Base
  attr_accessible :password, :user_name, :org
  belongs_to :user

  def to_string
    puts 'Printing Login'
    puts self.id
    puts self.password
    puts self.user_name
    puts self.org
  end
end
