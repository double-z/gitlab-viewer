class Key < ActiveRecord::Base
  belongs_to :user

  validates :title,
            :presence => true,
            :length   => { :within => 0..255 }

  validates :key,
            :presence => true,
            :uniqueness => true,
            :length   => { :within => 0..555 }

  before_save :set_identifier

  def set_identifier
    self.identifier = "#{user.identifier}_#{Time.now.to_i}"
  end
  
   #projects that has this key
  def projects
    user.projects
  end
end
# == Schema Information
#
# Table name: keys
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  created_at :datetime
#  updated_at :datetime
#  key        :text
#  title      :string(255)
#  identifier :string(255)
#

