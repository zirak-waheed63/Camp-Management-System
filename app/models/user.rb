class User < ApplicationRecord
  validates :first_name, :last_name, :country, :phone_number, :encrypted_password, :email, presence: true
  validates :phone_number, numericality: true, length: {minimum: 10, maximum:15,
                                                        message: 'must be 10-15 digit number.'}
  validate :password_requirements_are_met
  validates :email,
  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "invalid"  }, length: { minimum: 4, maximum: 254 }  

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  def password_requirements_are_met
    rules = {
      ' must contain at least one lowercase letter' => /[a-z]+/,
      ' must contain at least one uppercase letter' => /[A-Z]+/,
      ' must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match(regex)
    end
  end
end
