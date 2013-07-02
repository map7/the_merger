require 'spec_helper'
include TheMerger

class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :mobile, :home_phone, :work_phone, :address, :suburb, :state, :postcode
end

describe TheMerger do

  before do
    @user = User.create(firstname: "Michael", lastname: "Pope", email: "map7777@gmail.com")
  end

  describe "#merge_fields" do
    context "body is set to Dear [firstname] [lastname]" do
      it "replaces [firstname] & [lastname] with Michael & Pope respectively" do
        merge_fields("Dear [firstname] [lastname]",@user).should eq("Dear Michael Pope")
      end
    end

    context "body is set to Dear [firstname] [lastname], [address]" do
      it "replaces fields which exist in the model" do
        merge_fields("Dear [firstname] [lastname], [address]",@user).should eq("Dear Michael Pope, [address]")
      end
    end
  end

  describe "#fields" do
    it "returns fields for the model excluding created_at, updated_at & id" do
      fields.should eq(%w[firstname lastname email])
    end
  end
end
