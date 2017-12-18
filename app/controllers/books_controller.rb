class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource
  skip_authorize_resource :only => :index

  def index
    @books = Book.paginate(page: params[:page], per_page:8)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    if @book.save
        flash[:success] = "Book added successfully!"
        redirect_to @book
    else 
        render 'new'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        carts = Order.all.select { |o| o.cart == true }
        carts.each do |c|
          orderitems = c.order_items
           orderitems.each do |oi|
            if oi.book.id == @book.id
              oi.cost = @book.price 
              oldtotalcost = oi.total_cost
              oi.total_cost = oi.quantity * @book.price
              c.total_cost = (c.total_cost - oldtotalcost) + oi.total_cost
              c.save
              oi.save
            end
           end 
        end 
        format.html { redirect_to @book }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def stock
    @books = Book.order('quantity ASC').all
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rate 
    @book = Book.find(params[:id])
    rat =  params[:book][:rating].to_i
    tot = @book.rating.to_f * @book.raters.to_i
    numberofraters = @book.raters.to_i + 1 
    newrating = (tot + rat) / numberofraters 
    
    
    @book.update_attributes(raters: numberofraters, rating: newrating)
    #@book.rating = @newrating.to_f
    redirect_to @book

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name,:isbn,:author,:rating,:category,:language,:publisher,:ordered_times,:price,:image,:quantity,:description,category_ids:[])
    end

end
