class Country < ActiveRecord::Base
  establish_connection(:spree_user)
end