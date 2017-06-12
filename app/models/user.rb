class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  has_many :reviews
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  def self.authenticate_with_credentials(email, password)
    email_no_spaces = email.delete(' ')
    user = User.where("lower(email) =?", email_no_spaces.downcase).first
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      user
    else
    # If user's login doesn't work, send them back to the login form.
      return nil
    end
  end
end
