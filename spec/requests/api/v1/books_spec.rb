require 'swagger_helper'

RSpec.describe 'Books Api', swagger_doc: 'v1/books.json' do
  before do
    @author = create(:author)
  end

  path '/api/v1/books' do
    get 'fetch books accept fillter' do
      tags 'book'

      security [Bearer: {}]

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :title, in: :query, type: :string, required: false
      parameter name: :author_name, in: :query, type: :string, required: false

      response '200', 'book list' do
        expected_response_schema = SpecSchemas::BookFilterResponse.new
        schema(expected_response_schema.schema.as_json)

        before do
          create_list(:book, 3, author: @author)
        end

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { nil }
        end

        it 'correct data filtered' do
          data = JSON.parse(response.body)
          expect(data['data'].size).to eq(3)
        end
      end
    end

    post 'Create a book' do
      tags 'book'
      security [Bearer: {}]

      expected_request_schema = SpecSchemas::BookCreateResquest.new
      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      let(:build_book) { build_stubbed(:book) }

      response(201, 'book created') do
        expected_response_schema = SpecSchemas::BookResponse.new
        schema(expected_response_schema.schema.as_json)

        let(:params) do
          { book: { title: build_book.title, price: build_book.price_cents },
            author_id: @author.id }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 201 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { expected_request_schema }
        end

        it 'success' do
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['title']).to eq(build_book.title)
          expect(data['data']['attributes']['id']).not_to be_nil
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:params) do
          { book: { title: '' }, author_id: @author.id }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it 'failed' do
          data = JSON.parse(response.body)
          expect(data['error']).not_to be_empty
        end
      end
    end
  end

  path '/api/v1/books/{id}' do
    get 'Retrieve a book' do
      tags 'book'
      security [Bearer: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'book found' do
        expected_response_schema = SpecSchemas::BookResponse.new
        schema(expected_response_schema.schema.as_json)

        let(:id) { create(:book, author: @author).id }

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { nil }
        end

        it 'get book' do
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['id']).to match(id)
        end
      end

      response '404', 'book not found' do
        let(:id) { 'invalid' }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).not_to be_empty
        end
      end
    end

    put 'update a book' do
      tags 'book'
      security [Bearer: {}]

      expected_request_schema = SpecSchemas::BookUpdateResquest.new
      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json
      parameter name: :id, in: :path, required: true, type: :string

      response '200', 'updated' do
        expected_response_schema = SpecSchemas::BookResponse.new
        schema(expected_response_schema.schema.as_json)

        let(:id) { create(:book, author: @author).id }
        let(:params) do
          { book: { title: 'new title', price: 11.11 },
            author_id: @author.id }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { expected_request_schema }
        end

        it 'success' do
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['title']).to eq('new title')
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:id) { create(:book, author: @author).id }
        let(:params) { { book: { title: ' ' }, author_id: @author.id } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).not_to be_empty
        end
      end
    end

    delete 'delete a book' do
      tags 'book'
      security [Bearer: {}]

      parameter name: :id, in: :path, required: true, type: :string

      response '200', 'deleted' do
        let(:id) { create(:book, author: @author).id }

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 204 do
          let(:expected_response_schema) { {} }
          let(:expected_request_schema) { nil }
        end
      end
    end
  end
end
