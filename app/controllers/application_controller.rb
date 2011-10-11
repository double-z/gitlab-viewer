class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 

  def project 
    @project ||= Project.find_by_code(params[:project_id])
  end
end
