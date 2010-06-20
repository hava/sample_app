require 'spec_helper'

describe PagesController do
  integrate_views

  before(:each) do
    @base_title="Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end


    it "should have the right title" do
      get 'home'
      response.should have_tag("title",
                               @base_title +" | Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_tag("title",
                               @base_title +" | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_tag("title",
                               @base_title +" | About")
    end
  end


  describe "GET 'help'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_tag("title",
                               @base_title +" | Help")
    end
  end


  describe "Microposts count'" do

    before(:each) do
      @user = Factory(:user)
      # Arrange for User.find(params[:id]) to find the right user.
      User.stub!(:find, @user.id).and_return(@user)
    end
    it "should show in plural" do
      mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
      mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
      get :home, :id => @user
      response.should have_tag("span.microposts", "2 microposts")
    end

    it "should show in singular" do
      mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
      get :home, :id => @user
      response.should have_tag("span.microposts", "1 micropost")
    end

  end

  describe "Delete links'" do

    before(:each) do
      @user1 = Factory(:user)
      @user2 = Factory(:user, :email => "another@example.com")
      @mp1 = Factory(:micropost, :user => @user1, :content => "Foo bar")
      @mp2 = Factory(:micropost, :user => @user2, :content => "Baz quux")
      @posts = [@mp1, @mp2]
      # Arrange for User.find(params[:id]) to find the right user.
      User.stub!(:find, @user1.id).and_return(@user1)
    end
    
    it "should show for signed in user" do
      get :home, :id => @user1
      response.should have_tag("a[href=?]", "/microposts/#{@mp1.id}")
    end

    it "should not appear for not signed in user" do
      get :home, :id => @user1
      response.should_not have_tag("a[href=?]", "/microposts/#{@mp2.id}")
    end


  end
end
