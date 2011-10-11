require 'spec_helper'

describe "Top Panel", :js => true do
  describe "Search autocomplete" do
    before do 
      visit projects_path
      fill_in "search", :with => "Pro"
      sleep(2)
      find(:xpath, "//ul[contains(@class,'ui-autocomplete')]/li/a[.=\"Projects\"]").click
    end

    it "should be on projects page" do
      current_path.should == projects_path 
    end
  end

  describe "with project" do
    before do 
      @project = Factory :project
      visit project_path(@project)

      fill_in "search", :with => "Commi"
      sleep(2)
      find(:xpath, "//ul[contains(@class,'ui-autocomplete')]/li/a[.=\"#{@project.code} / Commits\"]").click
    end

    it "should be on projects page" do
      current_path.should == project_commits_path(@project) 
    end
  end
end
