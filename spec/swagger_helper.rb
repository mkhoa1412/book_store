# frozen_string_literal: true

require 'rails_helper'
require 'json/schema_builder'

# this block ensures if any schema element is extra or missing, the test fails.
JSON::SchemaBuilder.configure do |opts|
  opts.validate_schema = true
  opts.strict = true
end

# let spec know where your shiny new schemas are!
Dir['./spec/schemas/*.rb'].each { |file| require file }
Dir['./spec/support/**/*.rb'].sort.each { |file| require file }

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rswag::Api.config.swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/authors.json' => {
      swagger: '2.0',
      info: {
        title: 'API Session',
        version: 'v1'
      },
      consumes: ['application/json'],
      produces: ['application/json'],
      paths: {}
    },
    'v1/books.json' => {
      swagger: '2.0',
      info: {
        title: 'API Session',
        version: 'v1'
      },
      consumes: ['application/json'],
      produces: ['application/json'],
      paths: {}
    }
  }
end
