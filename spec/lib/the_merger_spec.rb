require 'spec_helper'
include TheMerger

class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :mobile, :home_phone, :work_phone, :address, :suburb, :state, :postcode
end

describe TheMerger do

  before do
    @user = User.create(firstname: "Michael", lastname: "Pope", email: "map7777@gmail.com")
  end
  
  describe "model_fields" do
    it "returns fields for the model excluding created_at, updated_at & id" do
      model_fields.should eq(%w[firstname lastname email])
    end
  end
end
