# encoding: utf-8

require "spec_helper"

describe "update_attributes" do
  describe_example "update_attributes/embeds_one" do
    it "updates customer item name" do
      @root.item.id.should == nil
      @root.item.name.should == "name"
    end
  end

  describe_example "update_attributes/simple" do
    it "updates customer login" do
      @root.login.should == "newjackiechan2010"
    end

    it "updates customer birth" do
      @root.birth.should be_a(Date)
      @root.birth.should == Date.new(1986, 01, 23)
    end
  end

  describe_example "update_attributes/embeds_many" do
    it "updates customer items" do
      @root.items.count.should == 1
      @root.items.first.id.should == 3000
    end
  end

  describe_example "update_attributes/has_one" do
    it "updates customer billing" do
      @root.billing.should_not be_nil
      @root.billing.login.should == "new_billing_login"
    end
  end

  describe_example "update_attributes/has_many" do
    it "updates customer services" do
      @root.services.should_not be_nil
      @root.services.count.should == 1
      @root.services.first.name.should == "new_service_name"
    end
  end

  describe_example "update_attributes/with_nil_value" do
    it "updates only the customers login" do
      @root.login.should_not be
      @root.id.should == 200
    end
  end
end
