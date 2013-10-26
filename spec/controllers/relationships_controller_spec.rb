require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!


describe RelationshipsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  
  before do
    login_as(user)
  end
  
  #before { sign_in user }
  
  describe "creating a relationship with Ajax" do
    it "should increment the Relationship count" do
    
      expect do
        xhr :post, :create, relationship: { included_id: other_user.id }
      end.should change(Relationship, :count).by(1)
    end
  
    it "should respond with success" do
      xhr :post, :create, relationship: { inlcuded_id: other_user.id }
      response.should be_success
    end
  end
  
  describe "destroying a relationship with Ajax" do
    before { user.include!(other_user) }
    
    let(:relationship) { user.relationships.find_by_inlcuded_id(other_user)}
    
    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.should change(Relationship, :count).by(-1)
    end
  
    it "should respond with success" do
      xhr :delete, :destroy, id: relationship.id
      response.should be_success
    end
  end
  
  # To get Warden user login mechanism working correctly reset 
  # Warden after each test.
  Warden.test_reset!
end
