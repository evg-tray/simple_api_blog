RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:author) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
  end
end
