RSpec::Matchers.define :be_valid_commit do
  match do |actual|
    actual != nil
    actual.id == ValidCommit::ID
    actual.message == ValidCommit::MESSAGE
    actual.author.name == ValidCommit::AUTHOR_FULL_NAME
  end
end
