require 'swagger_helper'

RSpec.describe 'Authors Api', swagger_doc: 'v1/authors.json' do
  path '/api/v1/authors' do
    get 'fetch authors accept fillter' do
      tags 'author'

      security [Bearer: {}]

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :name, in: :query, type: :string, required: false

      response '200', 'author list' do
        expected_response_schema = SpecSchemas::AuthorFilterResponse.new
        schema(expected_response_schema.schema.as_json)

        before do
          create_list(:author, 3)
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

    post 'Create a author' do
      tags 'author'
      security [Bearer: {}]

      expected_request_schema = SpecSchemas::AuthorCreateResquest.new
      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json

      let(:build_author) { build_stubbed(:author) }

      response(201, 'author created') do
        expected_response_schema = SpecSchemas::AuthorResponse.new
        schema(expected_response_schema.schema.as_json)

        let(:params) do
          { author: { name: build_author.name } }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 201 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { expected_request_schema }
        end

        it 'created author' do
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['name']).to eq(build_author.name)
          expect(data['data']['attributes']['id']).not_to be_nil
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:params) do
          { author: { name: '' } }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it 'failed on duplicated name' do
          data = JSON.parse(response.body)
          expect(data['error']).not_to be_empty
        end
      end
    end
  end

  path '/api/v1/authors/{id}' do
    get 'Retrieve a author' do
      tags 'author'
      security [Bearer: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'author found' do
        expected_response_schema = SpecSchemas::AuthorResponse.new
        schema(expected_response_schema.schema.as_json)

        let(:id) { create(:author).id }

        before do |example|
          submit_request(example.metadata)
        end

        it_behaves_like 'a JSON endpoint', 200 do
          let(:expected_response_schema) { expected_response_schema }
          let(:expected_request_schema) { nil }
        end

        it 'get author' do
          data = JSON.parse(response.body)
          expect(data['data']['attributes']['id']).to match(id)
        end
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).not_to be_empty
        end
      end
    end

    put 'update a author' do
      tags 'author'
      security [Bearer: {}]

      expected_request_schema = SpecSchemas::AuthorUpdateResquest.new
      parameter name: :params, in: :body, schema: expected_request_schema.schema.as_json
      parameter name: :id, in: :path, required: true, type: :string

      response '200', 'updated' do
        expected_response_schema = SpecSchemas::AuthorResponse.new
        schema(expected_response_schema.schema.as_json)

        let(:id) { create(:author).id }
        let(:params) do
          { author: { name: 'new name' } }
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
          expect(data['data']['attributes']['name']).to eq('new name')
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:id) { create(:author).id }
        let(:params) { { author: { name: ' ' } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).not_to be_empty
        end
      end
    end

    delete 'delete a author' do
      tags 'author'
      security [Bearer: {}]

      parameter name: :id, in: :path, required: true, type: :string

      response '200', 'deleted' do
        let(:id) { create(:author).id }

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
