class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirersmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :organizations
         
   validates :email, presence: true, :uniqueness => true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, :length => {:minimum => 6, :maximum => 254}
   #validates :first_name, :last_name, presence: true
end
