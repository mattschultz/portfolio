require "spec_helper"

describe Project do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:description) }
  it { should validate_format_of(:url).with(/^(#{URI::regexp(%w(http https))})$|^$/) }
  
  it "should sort projects by ascending position" do
    project_1 = Factory(:project, position: 2)
    project_2 = Factory(:project, position: 1)
    Project.all.to_a.should == [project_2, project_1]
  end
end
