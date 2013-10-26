require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Authentication" do
  subject { page }
  
  #let(:user) { FactoryGirl.create(:user) }
  before do
    #login_as(user)
  end
  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      
      describe "in the Microposts controller" do
        describe "submitting to the create action" do
        
          #Fix this when i go online......................................................
          #before { post microposts_path }
          #specify { response.should redirect_to(signin_path) }
        end
        
        describe "submitting to the destroy action" do
          
          #Fix this when I go online......................................................
          #before { delete micropost_path(FactoryGirl.create(:micropost)) }
          #specify { response.should redirect_to(signin_path) }
        end
        
        #Write a following test
        #Write a followers test.
      end
    end
  end
  
  # To get Warden user login mechanism working correctly reset 
  # Warden after each test.
  Warden.test_reset!
end