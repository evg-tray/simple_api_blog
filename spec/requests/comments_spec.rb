RSpec.describe 'Comments API' do
  let(:user) { create(:user) }
  let!(:same_post) { create(:post) }
  let(:post_id) { same_post.id }
  let!(:comments) { create_list(:comment, 20, post_id: same_post.id) }
  let(:id) { comments.first.id }
  let(:headers) { valid_headers.except('Authorization') }
  let(:headers_with_auth) { valid_headers }

  describe 'GET /api/v1/posts/:post_id/comments' do
    context 'when post exists' do
      context 'without pagination params' do
        before { get "/api/v1/posts/#{post_id}/comments", headers: headers }

        it 'returns status code 200' do
          expect(response.status).to eq 200
        end

        it 'returns comments ordered by published_at asc' do
          expect(json).not_to be_empty
          expect(json.size).to eq(5)
          expect(json.map{ |i| i['id'] }).to eq comments.sort_by { |i| i['published_at'] }.map(&:id)[0..4]
        end

        it 'returns total pages, total count in headers' do
          expect(response.headers['X-Total-Pages']).to eq 4
          expect(response.headers['X-Total-Count']).to eq 20
        end
      end

      context 'with pagination params' do
        before { get "/api/v1/posts/#{post_id}/comments", params: {page: 2, per_page: 10}, headers: headers }

        it 'returns status code 200' do
          expect(response.status).to eq 200
        end

        it 'returns comments ordered by published_at asc' do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
          expect(json.map{ |i| i['id'] }).to eq comments.sort_by { |i| i['published_at'] }.map(&:id)[10..19]
        end

        it 'returns total pages, total count in headers' do
          expect(response.headers['X-Total-Pages']).to eq 2
          expect(response.headers['X-Total-Count']).to eq 20
        end
      end
    end

    context 'when post does not exist' do
      let(:post_id) { 0 }

      before { get "/api/v1/posts/#{post_id}/comments", headers: headers }

      it 'returns status code 404' do
        expect(response.status).to eq 404
      end

      it 'returns a not found message' do
        expect(json['errors']).to include("Couldn't find Post with 'id'=#{post_id}")
      end
    end
  end

  describe 'GET /api/v1/posts/:post_id/comments/:id' do
    before { get "/api/v1/posts/#{post_id}/comments/#{id}", headers: headers }

    context 'when comment exists' do
      it 'returns status code 200' do
        expect(response.status).to eq 200
      end

      it 'returns comment' do
        expect(json['id']).to eq id
        expect(json['body']).to eq comments.first.body
        expect(json['author_nickname']).to eq comments.first.author.nickname
        expect(json['published_at']).not_to be_nil
      end
    end

    context 'when comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response.status).to eq 404
      end

      it 'returns a not found message' do
        expect(json['errors']).to include(/Couldn't find Comment with 'id'=0/)
      end
    end
  end

  describe 'POST /api/v1/posts/:post_id/comments' do
    let(:valid_attributes) { attributes_for(:comment).except(:author, :post) }

    context 'when request is valid' do
      before { post "/api/v1/posts/#{post_id}/comments", params: valid_attributes.to_json, headers: headers_with_auth }

      it 'returns status code 201' do
        expect(response.status).to eq 201
      end

      it 'creates a comment' do
        expect(json['id']).not_to be_nil
        expect(json['body']).to eq valid_attributes[:body]
        expect(json['author_nickname']).to eq user.nickname
        expect(json['published_at']).not_to be_nil
      end
    end

    context 'when request is valid without published_at in params' do
      before do
        post "/api/v1/posts/#{post_id}/comments",
             params: valid_attributes.except(:published_at).to_json,
             headers: headers_with_auth
      end

      it 'creates a comment' do
        expect(json['id']).not_to be_nil
        expect(json['body']).to eq valid_attributes[:body]
        expect(json['author_nickname']).to eq user.nickname
        expect(json['published_at']).not_to be_nil
      end

      it 'returns status code 201' do
        expect(response.status).to eq 201
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/posts/#{post_id}/comments", params: {}, headers: headers_with_auth }

      it 'returns status code 422' do
        expect(response.status).to eq 422
      end

      it 'returns a failure message' do
        expect(json['errors']).to include(/Body can't be blank/)
      end
    end
  end
end
