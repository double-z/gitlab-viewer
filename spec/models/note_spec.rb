require 'spec_helper'

describe Note do
  describe "Associations" do
    it { should belong_to(:project) }
  end

  describe "Validation" do
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:project) }
  end

  it { Factory.create(:note,
                      :project => Factory.create(:project)).should be_valid }

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

