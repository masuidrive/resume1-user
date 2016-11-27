class EssaysController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_category

  def edit
  end

  private
  def prepare_category
    @category = Category.find_by(uid: params[:category_id])
    head :not_found unless @category
    @essay = current_user.essays
      .where(topics: {category_id: @category.id})
      .includes(:topic => :category)
      .first || current_user.essays.build
  end
end