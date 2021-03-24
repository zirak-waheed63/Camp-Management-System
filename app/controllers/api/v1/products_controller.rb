class Api::V1::ProductsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def index
    products = Product.all
    render json: products
  end

  def show
    product = Product.find(params[:id])
    if product.save
      render json: product, status: 200
    else
      render json: { error: 'Could not find product' }, status: 200
    end
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: 200
    else
      render json: { error: 'Could not create product' }
    end
  end

  private

  def product_params
    params.permit(:name, :brand, :price, :description)
  end
end
