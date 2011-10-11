require File.join(Rails.root, 'spec', 'factory')

Factory.add(:project, Project) do |obj|
  obj.name = Faker::Internet.user_name
  obj.path = 'legit'
  obj.code = 'LGT'
end

Factory.add(:note, Note) do |obj|
  obj.note = Faker::Lorem.sentence
end
