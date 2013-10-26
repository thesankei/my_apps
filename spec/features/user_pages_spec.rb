require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "User pages" do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_as(user)
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo")}
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar")}
    
    before { visit user_path(user) }
      
    it { should have_selector('h6',text: user.name) }
    it { page_title(page).should eq(full_title(user.name))}
  
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
    
    #Go through this code again!!!
    describe "Inlude/Exclude buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      
      #before { sign_in user }
      
      describe "inluded a user" do
        before { visit user_path(other_user) }
        
        it "should increment the followed user count" do
          expect do
            click_button "Include"
          end.to change(user.included_users, :count).by(1)
        end
        
        it "should increment the other user's outlets count" do
          expect do
            click_button "Include"
          end.to change(other_user.outlets, :count).by(1)
        end
      
        describe "toggling the button" do
          before { click_button "Inlude" }
        
          #it { should have_selector('input', value: 'Unfollow') }
        end
      end
      
      describe "excluding a user" do
        before do
          user.inlcude!(other_user)
          visit user_path(other_user)
        end
        
        it "should decrement the followed user count" do
          expect do
            click_button "Exclude"
          end.to change(user.inlcuded_users, :count).by(-1)
        end
      
        it "should decrement the other user's ouitlets count" do
          expect do
            click_button "Exclude"
          end.to change(other_user.outlets, :count).by(-1)
        end
      
        describe "toggling the button" do
          before { click_button "Exclude" }
          
          #it { should have_selector('input', value: 'Follow') }
        end
      end
    end
  end
  
  describe "inlcuding/outlets" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.inlcude!(other_user) }
    
    #Make sure this test passes
    describe "Included users" do
      before do
        #sign_in user
        visit inlcuded_user_path(user)
      end
    
      it { page_title(page).should eq(full_title('Included'))}
      it { should have_selector('h3', text: 'Included') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end
    
    #Make sure this test passes.
    describe "Outlets" do
      before do
        #sign_in other_user
        visit outlets_user_path(other_user)
      end
    
      it { page_title(page).should eq(full_title('Outlets'))}
      it { should have_selector('h3', text: 'Outlets') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
  
  # To get Warden user login mechanism working correctly reset 
  # Warden after each test.
  Warden.test_reset!
end