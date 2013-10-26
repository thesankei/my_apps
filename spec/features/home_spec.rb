require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Home" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    login_as(user)
  end
  
  describe "Index page" do
  
    let(:user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
      FactoryGirl.create(:micropost, user: user, content: "Dolor sitamet")
      
      #sign_in user
      #visit root_path
      visit home_index_path
    end
    
    it { should have_content 'Njooh' }
    it { page_title(page).should eq(full_title(''))}
    it { should_not have_selector 'title', text: '| Home' }
    
    it "should render the user's feed" do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
      end
    end
  
    describe "outlet/inlet counts" do
      let(:other_user) { FactoryGirl.create(:user) }
      
      before do
        other_user.include!(user)
        visit root_path
      end
      
      it { should have_link("0 included", href: included_user_path(user)) }
      it { should have_link("1 outlets", href: outlets_user_path(user)) }
    end   
  end
  
  describe "About page" do
    before { visit about_path }
    
    it { should have_selector('h1',text: 'Njooh Concept') }
    it { page_title(page).should eq(full_title('What is Njooh'))}
  end
  
  describe "Careers page" do
    before { visit careers_path }
    
    it { should have_selector('h1',text: 'Opportunities @ Njooh') }
    it { page_title(page).should eq(full_title('Opportunities to Contribute to Njooh'))}
  end
  
  describe "Developers page" do
    before { visit developer_path }
    
    it { should have_selector('h1',text: 'Creators') }
    it { page_title(page).should eq(full_title('Creators'))}
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_selector('h1',text: 'Contact Crew') }
    it { page_title(page).should eq(full_title('Contact Crew'))}
  end
  
  # To get Warden user login mechanism working correctly reset 
  # Warden after each test.
  Warden.test_reset!
end