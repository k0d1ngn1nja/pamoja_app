class Buyer < ActiveRecord::Base
  has_one :cart
end
