class User < ApplicationRecord
  paginates_per 3
  validates :terms, acceptance: {message: 'not accepted: contact Admin at xyz@projectname.com ' }
  validates :first_name, :last_name, :country, :phone_number, :encrypted_password, :email, presence: true
  validates :phone_number, numericality: true, length: {minimum: 10, maximum:15,
                                                        message: 'must be 10-15 digit number.'}
  validate :password_requirements_are_met
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  private
  def self.to_csv
    attributes = %w[id email first_name middle_name last_name country phone_number]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end

  def password_requirements_are_met
    rules = {
      ' must contain at least one lowercase letter' => /[a-z]+/,
      ' must contain at least one uppercase letter' => /[A-Z]+/,
      ' must contain at least one special character' => /[^A-Za-z0-9]+/
    }
    if password.present?
      rules.each do |message, regex|
        errors.add( :password, message ) unless password.match( regex )
      end
    end
  end

  def self.search(query)
    where('first_name LIKE ? OR last_name LIKE ? OR email LIKE ? OR id LIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
