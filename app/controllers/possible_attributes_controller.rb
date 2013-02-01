class PossibleAttributesController < ApplicationController
  before_filter :signed_in_user
  #before_filter :admin_user

  def index
    @possible_attributes = PossibleAttribute.all
  end

  def new
    @possible_attribute = PossibleAttribute.new
    render 'edit'
  end

  def show
    render 'edit'
  end

  def create
  	@possible_attribute = PossibleAttribute.new(params[:possible_attribute])
    if @possible_attribute.save
      flash[:success] = "Attribute created!"
      @possible_attributes = PossibleAttribute.all
      render 'index'
    else
      render 'edit'
    end
  end

  def edit
    @possible_attribute = PossibleAttribute.find(params[:id])
  end

  def update
  	@possible_attribute = PossibleAttribute.find(params[:id])
    if @possible_attribute.update_attributes(params[:possible_attribute])
      flash[:success] = "Attribute updated!"
      @possible_attributes = PossibleAttribute.all
      redirect_to possible_attributes_path
    else
      render 'edit'
    end
  end

  def destroy
    PossibleAttribute.find(params[:id]).destroy
    flash[:success] = "Attribute destroyed."
    #@possible_attributes = PossibleAttribute.all
    #render 'index'
    redirect_to possible_attributes_path
  end

  def possible_values
    @possible_attribute = PossibleAttribute.find(params[:id])
    @title = @possible_attribute.name
    @possible_attribute_values = PossibleAttributeValue.where("possible_attribute_id = ?", @possible_attribute.id)
    #@possible_attribute_value = @possible_attribute.possible_attribute_values.build
    #@new_possible_attribute_value = PossibleAttributeValue.new
    #@possible_attribute_value = @possible_attribute.possible_attribute_values.build(@new_possible_attribute_value.id)
    #@micropost = current_user.microposts.build(params[:micropost])
    @possible_attribute_value = PossibleAttributeValue.new
    render 'show_possible_values'
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
