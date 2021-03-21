module SpecSchemas
  class AuthorFilterResquest
    include JSON::SchemaBuilder
    def schema
      object do
      end
    end
  end

  class AuthorCreateResquest
    include JSON::SchemaBuilder
    def schema
      object do
        object :author do
          string :name, required: true
        end
      end
    end
  end

  class AuthorUpdateResquest
    include JSON::SchemaBuilder
    def schema
      object do
        object :author do
          string :name, required: true
        end
      end
    end
  end

  class AuthorResponse
    include JSON::SchemaBuilder
    def schema
      object do
        object :data do
          string :id, required: true
          string :type, required: true
          object :attributes do
            integer :id, required: true
            string :name, required: true
          end
        end
      end
    end
  end

  class AuthorFilterResponse
    include JSON::SchemaBuilder
    def schema
      object do
        array :data do
          items  type: :object do
            string :id, required: true
            string :type, required: true
            object :attributes do
              integer :id, required: true
              string :name, required: true
            end
          end
        end
        object :meta do
          object :pagy do
            integer :count, required: true
            integer :page, required: true
            integer :prev, required: true, null: true
            integer :next, required: true, null: true
            integer :last, required: true
            integer :from, required: true
          end
        end
      end
    end
  end
end
