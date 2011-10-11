class NotesController < ApplicationController
  before_filter :project 
  respond_to :js

  def create
    @note = @project.notes.new(params[:note])
    @note.save!

    respond_to do |format|
      format.html {redirect_to :back}
      format.js  
    end
  end

  def destroy
    @note = @project.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.js { render :nothing => true }  
    end
  end
end
