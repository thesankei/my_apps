require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "MicropostPages" do
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_as(user)
  end
  
  
  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Njooh It!" }.should_not change(Micropost, :count)
      end
  
    describe "error messages" do
      before { click_button "Njooh It!" }
      it { should have_content('error') }
    end
  end
  
  describe "with valid information" do
    before { fill_in 'micropost_content', with: "Lorem ipsum" }
    
      it "should create a micropost" do
        expect { click_button "Njooh It!" }.should change(Micropost,:count).by(1)
      end
    end
  end
  
  #When you delete a micropost they should decrease by one.
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
    
    describe "as correct user" do
      before { visit root_path }
      
      it "should delete a micropost" do
        expect { click_link "delete" }.should change(Micropost, :count).by(-1)
      end
    end
  end

  # To get Warden user login mechanism working correctly reset 
  # Warden after each test.
  Warden.test_reset!
end
