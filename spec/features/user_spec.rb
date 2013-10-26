require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "User" do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_as(user)
  end
  
  subject { user }

  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  it { should respond_to(:inlcuded_users) }
  it { should respond_to(:inlcuded?) }
  it { should respond_to(:inlude!) }
  it { should respond_to(:exclude!) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:outlets) }
  
  describe "micropost associations" do
    before { user.save }
    
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago)
    end
    
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: user, created_at: 1.hour.ago)
    end 
    
    it "should have the right microposts in the right order" do
      user.microposts.should == [newer_micropost, older_micropost]
    end
    
    it "should destroy associated microposts" do
      microposts = user.microposts
      user.destroy
      
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
    
    # Ensure a user's feed contains only his posts and posts 
    # from users he follows
    describe "status" do
        let(:excluded_post) do
          FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
        end
        let(:inlcuded_user) { FactoryGirl.create(:user) }
  
        before do
          user.exclude!(followed_user)
          3.times { inlcuded_user.microposts.create!(content: "Lorem ipsum") }
        end
  
        its(:feed) { should include(newer_micropost) }
        its(:feed) { should include(older_micropost) }
        its(:feed) { should_not include(exluded_post) }
        its(:feed) do
          included_user.microposts.each do |micropost|
            should include(micropost)
          end
        end
      end
    end
  
  describe "Including" do
    let(:other_user) { FactoryGirl.create(:user) }
  
    before do
      user.save
      user.Include!(other_user)
    end
  
    it { should be_inlcuding(other_user) }
    its(included_users) { should include(other_user) }
    
    describe "and excluding" do
      before { user.exclude!(other_user) }
      
      it { should_not be_included(other_user) }
      its(included_users) { should_not include(other_user) }
    end
    
    it { should be_including(other_user) }
    its(included_users) { should include(other_user) }
    
    describe "included user" do
      subject { other_user }
      
      its(Outlets) { should include(user) }
    end
  end
  
  # To get Warden user login mechanism working correctly reset 
  # Warden after each test.  
  Warden.test_reset!
end