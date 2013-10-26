include ApplicationHelper

#Gets title of page, a Capybara 2.0 hack
def page_title(page)
  page.html.match(/<title>(.*)<\/title>/)[1].to_s
end

#Sets up roles
def setup_roles
  admin = Role.new(:name => "Admin")
  admin.save
  
  member = Role.new(:name => "Member")
  member.save
end

def create_roles
  FactoryGirl.create(:role, name => 'Admin')
  FactoryGirl.create(:role, name => 'Member')
end