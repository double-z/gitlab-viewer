require 'spec_helper'

describe "Projects" do
  describe "GET /projects" do
    before do 
      visit projects_path
    end

    it "should be on projects page" do
      current_path.should == projects_path 
    end

    it "should have link to new project" do
      page.should have_content("New Project") 
    end
  end

  describe "GET /projects/new" do
    before do 
      visit projects_path
      click_link "New Project"
    end

    it "should be correct path" do
      current_path.should == new_project_path 
    end

    it "should have labels for new project" do
      page.should have_content("Name") 
      page.should have_content("Path") 
      page.should have_content("Description") 
    end
  end

  describe "POST /projects" do
    before do 
      visit new_project_path
      fill_in 'Name', :with => 'NewProject'
      fill_in 'Code', :with => 'NPR'
      fill_in 'Path', :with => '/tmp/legit_test/legit'
      expect { click_button "Create Project" }.to change { Project.count }.by(1)
      @project = Project.last
    end

    it "should be correct path" do
      current_path.should == project_path(@project)
    end

    it "should show project" do
      page.should have_content(@project.name)
    end
  end

  describe "GET /projects/show" do
    before do 
      @project = Factory :project

      visit project_path(@project)
    end

    it "should be correct path" do
      current_path.should == project_path(@project)
    end

    it_behaves_like :tree_view
  end

  describe "GET /projects/:id/edit" do
    before do 
      @project = Factory :project

      visit edit_project_path(@project)
    end

    it "should be correct path" do
      current_path.should == edit_project_path(@project)
    end

    it "should have labels for new project" do
      page.should have_content("Name") 
      page.should have_content("Path") 
      page.should have_content("Description") 
    end
  end

  describe "PUT /projects/:id" do
    before do 
      @project = Factory :project

      visit edit_project_path(@project)

      fill_in 'Name', :with => 'Awesome'
      fill_in 'Path', :with => 'legit'
      fill_in 'Description', :with => 'Awesome project'
      click_button "Update Project"
      @project = @project.reload
    end

    it "should be correct path" do
      current_path.should == project_path(@project)
    end

    it "should show project" do
      page.should have_content("Awesome")
    end

    it_behaves_like :tree_view
  end
end
