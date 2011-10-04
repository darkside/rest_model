require 'spec_helper'

def it_parses_property
  it 'parses property' do
    root.login.should == 'jackiechan2010'
  end
end

describe_example 'properties/simple' do
  it_parses_property
end

describe_example 'properties/with_field' do
  context 'when input has a different name for the property' do
    it_parses_property
  end
end

describe_example 'properties/with_field_path' do
  context 'when input has a different path for the property' do
    it_parses_property
  end
end

describe_example 'properties/with_id' do
  context 'when property is an id' do
    it 'parses id' do
      root.id.should == "2000"
    end
  end
end

describe_example 'properties/with_if' do
  context 'when a property has a conditional proc (:if)' do
    context 'and it evaluates to true' do
      it 'parses property' do
        root_with_description.description.should == "description"
      end
    end

    context 'and it evaluates to false' do
      it "doesn't parse property" do
        root_without_description.description.should_not be
      end
    end
  end
end

describe_example 'properties/with_key_converter' do
  after do
    RestModel::Configuration.configure do |c|
      c.convert_input_keys = nil
    end
  end

  context 'when a diferent key converter is configured on transcriber' do
    it_parses_property
  end
end

describe_example 'properties/with_two_key_converters' do
  context 'when key converters are configured for each class' do
    it_parses_property

    it 'parses other property with different key converter' do
      root.product.unit_price.should == 29.9
    end
  end
end
