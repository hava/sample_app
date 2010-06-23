require 'spec_helper'

describe "Relationships" do

  before(:each) do
    @user = Factory(:user,:email => Factory.next(:email))
    @followed = Factory(:user, :name => "Rob", :email => Factory.next(:email))
    visit signin_path
    click_button
  end

  it "Follow" do
    integration_sign_in(@user)
    click_link "Users"
    click_link "Rob"
    lambda {  click_button "Follow" }.should change(Relationship, :count).by(1)
  end

  it "Unfollow" do
    integration_sign_in(@user)
    click_link "Users"
    click_link "Rob"
    lambda {  click_button "Follow" }.should change(Relationship, :count).by(1)
    lambda {  click_button "Unfollow" }.should change(Relationship, :count).by(-1)
  end


end