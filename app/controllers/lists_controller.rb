class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]
  before_action :set_page
  before_action :restore_page_from_cookie, only: :index
  after_action :store_page_in_cookie, only: :index

  # GET /lists or /lists.json
  def index
    # @lists = List.all
    # @lists = List.order(day: :asc).paginate(page: @page, per_page: 18)
    page = (params[:page].presence || @restored_page || 1).to_i
    @lists = List.order(day: :asc).paginate(page: page, per_page: 18)
    # if requested page is invalid(deleted records, etc..), redirect to the last valid page
    if @lists.current_page > @lists.total_pages && @lists.total_pages > 0
      redirect_to lists_path(page: @lists.total_pages) and nil
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /lists/1 or /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_path(page: @page), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: lists_path(page: @page) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_path(page: @page), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: lists_path(page: @page) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_path(page: @page), notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:id])
  end

  def set_page
    @page = params[:page].presence
  end
  def restore_page_from_cookie
    @restored_page = cookies[:lists_page]
  end
  def store_page_in_cookie
    cookies.permanent[:lists_page] = @lists.current_page
  end
    # Only allow a list of trusted parameters through.
  def list_params
    params.require(:list).permit(:day, :date, :msg, :title, :page)
  end
end
