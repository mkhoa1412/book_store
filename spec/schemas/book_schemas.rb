module SpecSchemas
  class BookFilterResquest
    include JSON::SchemaBuilder
    def schema
      object do
      end
    end
  end

  class BookCreateResquest
    include JSON::SchemaBuilder
    def schema
      object do
        object :book do
          string :title, required: true
          number :price, required: true
        end
        integer :author_id, required: true
      end
    end
  end

  class BookUpdateResquest
    include JSON::SchemaBuilder
    def schema
      object do
        object :book do
          string :title, required: true
          number :price, required: true
        end
        integer :author_id, required: true
      end
    end
  end

  class BookResponse
    include JSON::SchemaBuilder
    def schema
      object do
        object :data do
          string :id, required: true
          string :type, required: true
          object :attributes do
            integer :id, required: true
            string :title, required: true
            object :price do
              number :cents, required: true
              string :currency_iso, required: true
            end
          end
          object :relationships, required: true do
            object :author, required: true do
              object :data do
                string :id
                string :type
              end
            end
          end
        end
      end
    end
  end

  class BookFilterResponse
    include JSON::SchemaBuilder
    def schema
      object do
        array :data do
          items  type: :object do
            string :id, required: true
            string :type, required: true
            object :attributes do
              integer :id, required: true
              string :title, required: true
              object :price do
                number :cents, required: true
                string :currency_iso, required: true
              end
            end
            object :relationships, required: true do
              object :author, required: true do
                object :data do
                  string :id
                  string :type
                end
              end
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
