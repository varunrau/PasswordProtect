include Gibberish

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
    puts @password
    cipher = Gibberish::AES.new(@password)
    puts cipher
    self.key = cipher.enc(@password)
  end

  def decrypt_password
    cipher = Gibberish::AES.new(@password)
    self.password = cipher.dec(self.key)
    self.key = nil
  end

  public
  def set_session_password(password)
    @password = password
  end

end
