$:.push 'examples'; require 'helper'

class Customer < RestModel
  property :login, field: 'customer_login'
end

@root = Customer.new(login: 'jackiechan2010')
inspect_rest_model(@root)
