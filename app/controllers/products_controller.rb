class ProductsController < ApplicationController
  layout 'no_navbar', only: [:new, :create]

  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to @product, notice: "Product created successfully."
    else
      render :new
    end
  end

  def show
  end
end
