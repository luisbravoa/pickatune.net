class Email < ActiveRecord::Base
  validates :email, uniqueness: true
end
