require "grit"

class Project < ActiveRecord::Base
  has_many :notes, :dependent => :destroy

  validates :name,
            :uniqueness => true,
            :presence => true,
            :length   => { :within => 0..255 }

  validates :path,
            :uniqueness => true,
            :presence => true,
            :length   => { :within => 0..255 }
  
  validates :description,
            :length   => { :within => 0..2000 }

  validates :code,
            :presence => true,
            :uniqueness => true,
            :length   => { :within => 3..12 }

  before_save :format_code

  attr_protected :private_flag, :owner_id

  scope :public_only, where(:private_flag => false)

  def to_param
    code
  end

  def common_notes
    notes.where(:noteable_type => ["", nil])
  end

  def format_code
    read_attribute(:code).downcase.strip.gsub(' ', '')
  end

  def public?
    !private_flag
  end

  def private?
    private_flag
  end

  def url_to_repo
    path
  end
  
  def path_to_repo
    path
  end

  def repo 
    @repo ||= Grit::Repo.new(path_to_repo)
  end

  def tags
    repo.tags.map(&:name).sort.reverse
  end

  def repo_exists?
    repo rescue false
  end

  def commit(commit_id = nil)
    if commit_id
      repo.commits(commit_id).first
    else 
      repo.commits.first
    end
  end

  def tree(fcommit, path = nil)
    fcommit = commit if fcommit == :head
    tree = fcommit.tree
    path ? (tree / path) : tree
  end

  def valid_repo?
    repo
  rescue
    errors.add(:path, "Invalid repository path")
    false
  end
end
# == Schema Information
#
# Table name: projects
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  path         :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#  private_flag :boolean         default(TRUE), not null
#  code         :string(255)
#  owner_id     :integer
#

