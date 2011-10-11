class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :projects_limit

  has_many :users_projects, :dependent => :destroy
  has_many :projects, :through => :users_projects
  has_many :my_own_projects, :class_name => "Project", :foreign_key => :owner_id
  has_many :keys, :dependent => :destroy
  has_many :issues,
    :foreign_key => :author_id,
    :dependent => :destroy

  has_many :assigned_issues,
    :class_name => "Issue",
    :foreign_key => :assignee_id,
    :dependent => :destroy

  scope :not_in_project, lambda { |project|  where("id not in (:ids)", :ids => project.users.map(&:id) ) }

  def identifier
    email.gsub "@", "_"
  end

  def is_admin?
    admin
  end

  def can_create_project?
    true
  end
end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  admin                  :boolean         default(FALSE), not null
#  projects_limit         :integer
#

