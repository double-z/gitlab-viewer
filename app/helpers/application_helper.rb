require 'digest/md5'
module ApplicationHelper
  def gravatar_icon(user_email)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user_email)}?s=40&d=identicon"
  end

  def commit_name(project, commit)
    if project.commit.id == commit.id
      "master"
    else
      commit.id
    end
  end

  def admin_namespace?
    false
  end

  def projects_namespace?
    !current_page?(root_url) &&
      controller.controller_name != "keys" &&
      !admin_namespace?
  end

  def last_commit(project)
    if project.repo_exists?  
      time_ago_in_words(project.commit.committed_date) + " ago"
    else 
      "Never"
    end
  end

  def search_autocomplete_source
    projects = Project.all.map{ |p| { :label => p.name, :url => project_path(p) } }
    default_nav = [
      { :label => "Projects", :url => projects_path }
    ]

    project_nav = []

    if @project && !@project.new_record?
      project_nav = [
        { :label => "#{@project.code} / Wall", :url => wall_project_path(@project) }, 
        { :label => "#{@project.code} / Tree", :url => tree_project_path(@project) }, 
        { :label => "#{@project.code} / Commits", :url => project_commits_path(@project) }
      ]
    end

    [projects, default_nav, project_nav].flatten.to_json
  end

  def handle_file_type(file_name, mime_type)
    if file_name =~ /(\.rb|\.ru|\.rake|Rakefile|\.gemspec|\.rbx|Gemfile)$/
      :ruby
    elsif file_name =~ /\.py$/
      :python
    elsif file_name =~ /(\.pl|\.scala|\.c|\.cpp|\.java|\.haml|\.html|\.sass|\.scss|\.xml|\.php|\.erb)$/
      $1[1..-1].to_sym
    elsif file_name =~ /\.js$/
      :javascript
    elsif file_name =~ /\.sh$/
      :bash
    elsif file_name =~ /\.coffee$/
      :coffeescript
    elsif file_name =~ /\.yml$/
      :yaml
    elsif file_name =~ /\.md$/
      :minid
    else
      :text
    end
  end
end
