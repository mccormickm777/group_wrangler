class PossibleAttributeValuesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user

  def create
  	#@possible_attribute_value = PossibleAttributeValue.new(params[:possible_attribute_value])
    #@micropost = current_user.microposts.build(params[:micropost])
    @possible_attribute_value = PossibleAttributeValue.new(params[:possible_attribute_value])
    if @possible_attribute_value.save
      flash[:success] = "Possible attribute value created!"
    end
    redirect_to_show_possible_values
  end

  def update
  	@possible_attribute_value = PossibleAttributeValue.find(params[:id])
    if @possible_attribute_value.update_attributes(params[:possible_attribute_value])
      flash[:success] = "Possible attribute value updated!"
    end
    redirect_to_show_possible_values
  end

  def edit
  end

  def destroy
  	@possible_attribute_value = PossibleAttributeValue.find(params[:id])
    @possible_attribute_value.destroy
    flash[:success] = "Possible attribute value destroyed."
    redirect_to_show_possible_values
  end

  private

    def redirect_to_show_possible_values
      #@attribute = Attribute.find(@posssible_attribute_value.attribute_id)
      #render 'show_possible_values'
      #@possible_attribute = PossibleAttribute.find(params[:id])
      #@title = @possible_attribute.name
      #@possible_attribute_values = PossibleAttributeValue.where("possible_attribute_id = ?", @possible_attribute.id)
      #@possible_attribute_value = @possible_attribute.possible_attribute_values.build
      #render 'attributes/show_possible_values'
      @possible_attribute = PossibleAttribute.find(@possible_attribute_value.possible_attribute_id)
      redirect_to :controller => 'possible_attributes', :action => 'possible_values', :id => @possible_attribute.id
      #possible_values_possible_attribute_path(possible_attribute)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
