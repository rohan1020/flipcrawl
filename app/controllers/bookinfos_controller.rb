class BookinfosController < ApplicationController
  before_action :set_bookinfo, only: [:show, :edit, :update, :destroy]

  # GET /bookinfos
  # GET /bookinfos.json
  def index
    require 'will_paginate/array'
    @bookinfos = Bookinfo.all.paginate(:page => params[:page], :limit => 15)

    require 'csv'
    respond_to do |format|
      format.html
      format.csv { 
        @bookinfos = Bookinfo.all
        send_data @bookinfos.to_csv }
      format.xls { 
        @bookinfos = Bookinfo.all
        send_data @bookinfos.to_csv(col_sep: "\t") }

    end

  end

  def download_csv

    @bookinfos = Bookinfo.all.limit(10)

    require 'csv'

    send_data @bookinfos.to_csv

  end

  # GET /bookinfos/1
  # GET /bookinfos/1.json
  def show
  end

  # GET /bookinfos/new
  def new
    @bookinfo = Bookinfo.new
  end

  # GET /bookinfos/1/edit
  def edit
  end

  # POST /bookinfos
  # POST /bookinfos.json
  def create
    @bookinfo = Bookinfo.new(bookinfo_params)

    respond_to do |format|
      if @bookinfo.save
        format.html { redirect_to @bookinfo, notice: 'Bookinfo was successfully created.' }
        format.json { render :show, status: :created, location: @bookinfo }
      else
        format.html { render :new }
        format.json { render json: @bookinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookinfos/1
  # PATCH/PUT /bookinfos/1.json
  def update
    respond_to do |format|
      if @bookinfo.update(bookinfo_params)
        format.html { redirect_to @bookinfo, notice: 'Bookinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookinfo }
      else
        format.html { render :edit }
        format.json { render json: @bookinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookinfos/1
  # DELETE /bookinfos/1.json
  def destroy
    @bookinfo.destroy
    respond_to do |format|
      format.html { redirect_to bookinfos_url, notice: 'Bookinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookinfo
      @bookinfo = Bookinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookinfo_params
      params.require(:bookinfo).permit(:title, :pid, :price, :categories, :author, :metadata, :url, :mainimg, :imgs)
    end
end
