class Market < ActiveRecord::Base

  has_one :address
  has_many :products, through: :offerings
  has_many :offerings
  has_many :payment_types, through: :accepted_payments
  has_many :accepted_payments

  def self.with_addresses
    Market.includes(:address)
  end

end
