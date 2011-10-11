class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, :class_name => "User"
  belongs_to :assignee, :class_name => "User"
  has_many :notes, :as => :noteable

  attr_protected :author, :author_id, :project, :project_id

  validates_presence_of :project_id
  validates_presence_of :assignee_id
  validates_presence_of :author_id

  validates :title,
            :presence => true,
            :length   => { :within => 0..255 }
  
  validates :content,
            :presence => true,
            :length   => { :within => 0..2000 }

  scope :opened, where(:closed => false)
  scope :closed, where(:closed => true)
  scope :assigned, lambda { |u| where(:assignee_id => u.id)}
end
# == Schema Information
#
# Table name: issues
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  content     :text
#  assignee_id :integer
#  author_id   :integer
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  closed      :boolean         default(FALSE), not null
#

