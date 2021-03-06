class Admin::LabelsController < Admin::Base
  before_action :authenticate_user!
  authorize_resource
  def index
    @label = Label.new
    @labels = Label.page(params[:page]).per(20)
  end

  def show
    @products = Product.where(label_id: params[:id]).page(params[:page]).per(20)
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_labels_path
    else
      render :index
    end
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      redirect_to admin_labels_path
    else
      render :edit
    end
  end

  def destroy
    label = Label.find(params[:id])
    label.destroy
    redirect_to admin_labels_path
  end

  private
    def label_params
      params.require(:label).permit(:name)
    end
end
