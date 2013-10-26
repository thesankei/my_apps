require 'spec_helper'

describe "blogposts/edit" do
  before(:each) do
    @blogpost = assign(:blogpost, stub_model(Blogpost,
      :title => "MyString",
      :tags => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit blogpost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blogpost_path(@blogpost), "post" do
      assert_select "input#blogpost_title[name=?]", "blogpost[title]"
      assert_select "input#blogpost_tags[name=?]", "blogpost[tags]"
      assert_select "textarea#blogpost_content[name=?]", "blogpost[content]"
    end
  end
end
