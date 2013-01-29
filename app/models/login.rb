class Login < ActiveRecord::Base
  attr_accessible :password, :user_name, :org
  belongs_to :user
  before_save :encrypt_password
  after_save :decrypt_password

  def to_string
    puts 'Printing Login'
    puts self.id
    puts self.password
    puts self.user_name
    puts self.org
  end

  def encrypt_password
    cipher = Gibberish::AES.new(session[:password])
    self.key = cipher.enc(self.password)
    self.password = nil
  end

  def decrypt_password
    cipher = Gibberish::AES.new(session[:password])
    self.password = cipher.dec(self.key)
    self.key = nil
  end
end
