RSpec.describe 'Registration', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) { attributes_for(:user) }

  describe 'POST /api/v1/auth/signup' do
    context 'when valid request' do
      before { post '/api/v1/auth/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end
    end

    context 'when invalid request' do
      before { post '/api/v1/auth/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['errors']).to include('Email can\'t be blank')
        expect(json['errors']).to include('Nickname can\'t be blank')
        expect(json['errors']).to include('Password can\'t be blank')
        expect(json['errors']).to include('Password confirmation can\'t be blank')
      end
    end
  end
end
