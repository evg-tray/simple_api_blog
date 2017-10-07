RSpec.describe 'Posts API', type: :request do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 10, author: user) }
  let(:post_id) { posts.first.id }
  let(:headers) { valid_headers.except('Authorization') }
  let(:headers_with_auth) { valid_headers }

  describe 'GET /api/v1/posts' do
    context 'without pagination params' do
      before { get '/api/v1/posts', headers: headers }

      it 'returns posts ordered by published_at desc' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
        expect(json.map{ |i| i['id'] }).to eq posts.sort_by { |i| i['published_at'] }.reverse.map(&:id)[0..4]
      end

      it 'returns status code 200' do
        expect(response.status).to eq 200
      end

      it 'returns total pages, total count in headers' do
        expect(response.headers['X-Total-Pages']).to eq 2
        expect(response.headers['X-Total-Count']).to eq 10
      end
    end

    context 'with pagination params' do
      before { get '/api/v1/posts', params: {page: 2, per_page: 3}, headers: headers }

      it 'returns posts ordered by published_at' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
        expect(json.map{ |i| i['id'] }).to eq posts.sort_by { |i| i['published_at'] }.reverse.map(&:id)[3..5]
      end

      it 'returns status code 200' do
        expect(response.status).to eq 200
      end

      it 'returns total pages, total count in headers' do
        expect(response.headers['X-Total-Pages']).to eq 4
        expect(response.headers['X-Total-Count']).to eq 10
      end
    end
  end

  describe 'GET /api/v1/posts/:id' do
    before { get "/api/v1/posts/#{post_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response.status).to eq 404
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Post with 'id'=#{post_id}")
      end
    end
  end

  describe 'POST /api/v1/posts' do
    let(:valid_attributes) { attributes_for(:post).except(:author) }

    context 'when request is valid' do
      before { post '/api/v1/posts', params: valid_attributes.to_json, headers: headers_with_auth }

      it 'creates a post' do
        expect(json['id']).not_to be_nil
        expect(json['title']).to eq valid_attributes[:title]
        expect(json['body']).to eq valid_attributes[:body]
        expect(json['author_nickname']).to eq user.nickname
        expect(json['published_at']).not_to be_nil
      end

      it 'returns status code 201' do
        expect(response.status).to eq 201
      end
    end

    context 'when request is valid without published_at in params' do
      before { post '/api/v1/posts', params: valid_attributes.except(:published_at).to_json, headers: headers_with_auth }

      it 'creates a post' do
        expect(json['id']).not_to be_nil
        expect(json['title']).to eq valid_attributes[:title]
        expect(json['body']).to eq valid_attributes[:body]
        expect(json['author_nickname']).to eq user.nickname
        expect(json['published_at']).not_to be_nil
      end

      it 'returns status code 201' do
        expect(response.status).to eq 201
      end
    end

    context 'when request is invalid' do
      before { post '/api/v1/posts', headers: headers_with_auth }

      it 'returns status code 422' do
        expect(response.status).to eq 422
      end

      it 'returns a validation failure message' do
        expect(json['errors']).to include('Title can\'t be blank')
        expect(json['errors']).to include('Body can\'t be blank')
      end
    end
  end
end
