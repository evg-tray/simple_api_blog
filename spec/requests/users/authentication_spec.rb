RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/v1/auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
          email: user.email,
          password: user.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
          email: Faker::Internet.email,
          password: Faker::Internet.password
      }.to_json
    end

    context 'When request is valid' do
      before { post '/api/v1/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/api/v1/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['errors']).to include(/Invalid email \/ password/)
      end
    end
  end
end
