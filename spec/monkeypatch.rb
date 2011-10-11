# Stubbing Project <-> gitosis path
# create project using Factory only
class Project 
  def path_to_repo 
    File.join(Rails.root, "tmp", "tests", path)
  end
end
