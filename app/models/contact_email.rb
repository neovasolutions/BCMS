class ContactEmail < ActiveRecord::Base
   establish_connection(:spree_user)
end
