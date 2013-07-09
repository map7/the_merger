require 'spec_helper'
include TheMerger

class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :age
end

describe TheMerger do

  before do
    @user = User.create(firstname: "Michael", lastname: "Pope", email: "map7777@gmail.com", age: 99)
  end

  describe "#mail_merge" do
    before do
      @second_user = User.create(firstname: "John", lastname: "Smith", email: "john.smith@gmail.com", age: 30)  
      @mailer = double()
      @mailer.stub(:deliver)
    end

    context "on model" do
      it "calls batch twice" do
        TheMerger::Mailer.should_receive(:batch_mail).twice.and_return(@mailer)
        mail_merge(from: 'user@example.com', subject: 'test merge', body: 'Hello [firstname]')
      end
    end

    context "subset of the model" do
      it "calls batch once" do
        TheMerger::Mailer.should_receive(:batch_mail).once.and_return(@mailer)
        mail_merge(from: 'user@example.com',
                   subject: 'test merge',
                   body: 'Hello [firstname]',
                   group: [@user])
      end
    end
  end

  describe "#merge_fields" do
    context "body is set to Dear [firstname] [lastname]" do
      it "replaces [firstname] & [lastname] with Michael & Pope respectively" do
        merge_fields("Dear [firstname] [lastname]",@user).should eq("Dear Michael Pope")
      end
    end

    context "body includes a number" do
      it "replaces [age] with 99" do
        merge_fields("Are you over [age] years old?",@user).should eq("Are you over 99 years old?")
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
      fields.should eq(%w[firstname lastname email age])
    end
  end
end
