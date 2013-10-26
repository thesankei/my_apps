require 'spec_helper'

describe "places/edit" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :name => "MyString",
      :description => "MyText",
      :location => "MyString",
      :data => "",
      :user => nil
    ))
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", place_path(@place), "post" do
      assert_select "input#place_name[name=?]", "place[name]"
      assert_select "textarea#place_description[name=?]", "place[description]"
      assert_select "input#place_location[name=?]", "place[location]"
      assert_select "input#place_data[name=?]", "place[data]"
      assert_select "input#place_user[name=?]", "place[user]"
    end
  end
end
