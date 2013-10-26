require 'spec_helper'

describe "blogposts/new" do
  before(:each) do
    assign(:blogpost, stub_model(Blogpost,
      :title => "MyString",
      :tags => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new blogpost form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blogposts_path, "post" do
      assert_select "input#blogpost_title[name=?]", "blogpost[title]"
      assert_select "input#blogpost_tags[name=?]", "blogpost[tags]"
      assert_select "textarea#blogpost_content[name=?]", "blogpost[content]"
    end
  end
end
