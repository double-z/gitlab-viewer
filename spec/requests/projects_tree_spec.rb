require 'spec_helper'

describe "Projects" do
  describe "GET /projects/tree" do
    describe "head" do
      before do 
        @project = Factory :project

        visit tree_project_path(@project)
      end

      it "should be correct path" do
        current_path.should == tree_project_path(@project)
      end

      it_behaves_like :tree_view
    end

    describe ValidCommit::ID do
      before do 
        @project = Factory :project

        visit tree_project_path(@project, :commit_id => ValidCommit::ID)
      end

      it "should be correct path" do
        current_path.should == tree_project_path(@project)
      end

      it_behaves_like :tree_view
      it_behaves_like :project_side_pane
    end

    describe "branch passed" do
      before do 
        @project = Factory :project
        visit tree_project_path(@project, :branch => "master")
      end

      it "should be correct path" do
        current_path.should == tree_project_path(@project)
      end

      it_behaves_like :tree_view
      it_behaves_like :project_side_pane
    end

    # TREE FILE PREVIEW
    describe "file preview" do
      before do 
        @project = Factory :project

        visit tree_project_path(@project, :path => ".rvmrc")
      end

      it "should be correct path" do
        current_path.should == tree_project_path(@project)
      end

      it "should contain file view" do
        page.should have_content("rvm use 1.9.2@legit")
      end
    end
  end

  # RAW FILE 
  describe "GET /projects/blob" do
    before do 
      @project = Factory :project

      visit blob_project_path(@project,
                              :path => ValidCommit::BLOB_FILE_PATH,
                              :commit_id => ValidCommit::ID)
    end

    it "should be correct path" do
      current_path.should == blob_project_path(@project)
    end

    it "raw file response" do 
      page.source.should == ValidCommit::BLOB_FILE
    end
  end
end
