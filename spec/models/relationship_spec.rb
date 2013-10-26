require 'spec_helper'

describe Relationship do
  let(outlets) { FactoryGirl.create(:user) }
  let(inlets) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id:followed.id) }
  
  subject { relationship }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to outlet_id" do
      expect do
        Relationship.new(outlet_id: outlet.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "outlet methods" do
    it { should respond_to(outlet) }
    it { should respond_to(inlet) }
    
    its(outlet) { should == outlet }
    its(inlet) { should == inlet }
  end
  
  describe "when inlet id is not present" do
    before { relationship.inlet_id = nil }
    it { should_not be_valid }
  end
  
  describe "when outlet id is not present" do
    before { relationship.outlet_id = nil }
    it { should_not be_valid }
  end
end
