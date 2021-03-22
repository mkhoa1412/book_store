class Api::V1::BooksController < Api::BaseController
  before_action :set_author, only: %i[create update]

  # GET /books
  def index
    @pagy, @books = pagy(fetch_data)
    options = { meta: { pagy: pagy_metadata(@pagy) } }
    success_response(BookSerializer.new(@books, options).serializable_hash, :ok)
  end

  # GET /books/1
  def show
    @book = Book.find(params[:id])
    success_response(BookSerializer.new(@book).serializable_hash, :ok)
  end

  # POST /books
  def create
    @book = @author.new_book(book_params)
    if @book.publish
      success_response(BookSerializer.new(@book).serializable_hash, :created)
    else
      error_response(@book, :unprocessable_entity)
    end
  end

  # PATCH/PUT /books/1
  def update
    @book = @author.book(params[:id])
    if @book.update(book_params)
      success_response(BookSerializer.new(@book).serializable_hash, :ok)
    else
      error_response(@book, :unprocessable_entity)
    end
  end

  # DELETE /books/1
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    success_response({}, :no_content)
  end

  private

  def fetch_data
    Book.includes(:author).filter_by_title(filter_params[:title]).order(created_at: :desc)
  end

  def filter_params
    params.permit(:title, :author_name)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:author_id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :price)
  end
end
