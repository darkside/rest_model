# encoding: utf-8

$:.push 'examples'; require 'helper'

class Item < RestModel
  property :id, type: Integer
end

class Root < RestModel
  embeds_many :items
end

@root = Root.from_source!(items: [{id: 2000}, {id: 2001}]).first

inspect_rest_model(@root)
