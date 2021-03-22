class Api::V1::AuthorsController < Api::BaseController
  before_action :set_author, only: %i[show update destroy]

  # GET /authors
  def index
    @pagy, @authors = pagy(fetch_data)
    options = { meta: { pagy: pagy_metadata(@pagy) } }
    success_response(AuthorSerializer.new(@authors, options).serializable_hash, :ok)
  end

  # GET /authors/1
  def show
    success_response(AuthorSerializer.new(@author).serializable_hash, :ok)
  end

  # POST /authors
  def create
    @author = Author.new(author_params)

    if @author.save
      success_response(AuthorSerializer.new(@author).serializable_hash, :created)
    else
      error_response(@author, :unprocessable_entity)
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      success_response(AuthorSerializer.new(@author).serializable_hash, :ok)
    else
      error_response(@author, :unprocessable_entity)
    end
  end

  # DELETE /authors/1
  def destroy
    @author.destroy
    success_response({}, :no_content)
  end

  private

  def fetch_data
    Author.filter_by_name(filter_params[:name])
  end

  def filter_params
    params.permit(:name)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:name)
  end
end
