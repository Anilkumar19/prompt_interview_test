class Organization < ActiveRecord::Base
	belongs_to :user

	validates :name, :org_identifier, :address_line1, :city, :state, :country, presence: true
	validates :zipcode, presence: true
end
