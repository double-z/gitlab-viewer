require 'spec_helper'

describe "Issues" do
  let(:project) { Factory :project }
  let!(:commit) { project.repo.commits.first }

  describe "add new note", :js => true do 
    before do 
      visit project_commit_path(project, commit)
      click_link "Comments" # notes tab
      fill_in "note_note", :with => "I commented this commit"
      click_button "Add note"
    end

    it "should conatin new note" do
      page.should have_content("I commented this commit")
    end
  end
end
