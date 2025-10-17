class ReviewsController < ApplicationController
  # We need to find the restaurant associated with the review
  before_action :set_restaurant, only: %i[ new create]

  def index
    @reviews = @restaurant.reviews.includes(:restaurant)
  end

  def new
    @review = @restaurant.reviews.new
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
   if @review.save
     redirect_to restaurant_path(@restaurant)
   else
     render :new
   end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
