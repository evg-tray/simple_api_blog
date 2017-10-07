RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:nickname) }
    it { should validate_uniqueness_of(:nickname).case_insensitive }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
  end

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key(:author_id) }
    it { should have_many(:comments) }
  end
end
