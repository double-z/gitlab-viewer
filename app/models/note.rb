require 'carrierwave/orm/activerecord'
require 'file_size_validator'

class Note < ActiveRecord::Base
  belongs_to :project
  belongs_to :noteable, :polymorphic => true

  validates_presence_of :project

  validates :note,
            :presence => true,
            :length   => { :within => 0..255 }

  validates :attachment, 
            :file_size => { 
              :maximum => 10.megabytes.to_i 
            } 

  scope :common, where(:noteable_id => nil)

  mount_uploader :attachment, AttachmentUploader
end
# == Schema Information
#
# Table name: notes
#
#  id            :integer         not null, primary key
#  note          :string(255)
#  noteable_id   :string(255)
#  noteable_type :string(255)
#  author_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#  project_id    :integer
#  attachment    :string(255)
#

