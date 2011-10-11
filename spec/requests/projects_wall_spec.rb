require 'spec_helper'

describe "Projects", "Wall" do
  let(:project) { Factory :project }

  describe "View notes on wall" do
    before do 
      Factory :note, :project => project, :note => "Project specs"
      visit wall_project_path(project)
    end

    it { page.should have_content("Project specs") }
    it { page.should have_content("less than a minute ago") }
  end

  describe "add new note", :js => true do 
    before do 
      visit wall_project_path(project)
      fill_in "note_note", :with => "my post on wall"
      click_button "Add note"
    end

    it "should conatin new note" do
      page.should have_content("my post on wall")
    end
  end
end
