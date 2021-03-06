class GatewaysController < ApplicationController
  before_action :set_gateway, only: [:show, :edit, :update, :destroy]
  before_filter :require_user_signed_in

  # GET /gateways
  # GET /gateways.json
  def index
    @gateways = Product.all.where(company: current_user.company, productable_type: 'Gateway')
  end

  # GET /gateways/1
  # GET /gateways/1.json
  def show
    @product = @gateway.product
  end

  # GET /gateways/new
  def new
    @gateway = Gateway.new
  end

  # GET /gateways/1/edit
  def edit
  end

  # POST /gateways
  # POST /gateways.json
  def create
    @gateway = Gateway.new(gateway_params)
    @gateway.uid = gateway_params[:email]
    @gateway.provider = 'email'
    @gateway.product.company_id = current_user.company.id if @gateway.product
    current_user.company.tag(@gateway, with: gateway_params[:tag_list], on: current_user.company.name.parameterize.underscore.to_sym)

    respond_to do |format|
      if @gateway.save
        format.html { redirect_to @gateway, notice: 'Gateway was successfully created.' }
        format.json { render :show, status: :created, location: @gateway }
      else
        format.html { render :new }
        format.json { render json: @gateway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gateways/1
  # PATCH/PUT /gateways/1.json
  def update
    current_user.company.tag(@gateway, with: gateway_params[:tag_list], on: current_user.company.name.parameterize.underscore.to_sym)
    respond_to do |format|
      hash = gateway_params
      hash[:product_attributes].merge!(company_id: current_user.company.id) if hash[:product_attributes]
      if @gateway.update(hash)
        format.html { redirect_to @gateway, notice: 'Gateway was successfully updated.' }
        format.json { render :show, status: :ok, location: @gateway }
      else
        format.html { render :edit }
        format.json { render json: @gateway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gateways/1
  # DELETE /gateways/1.json
  def destroy
    @gateway.destroy
    respond_to do |format|
      format.html { redirect_to gateways_url, notice: 'Gateway was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gateway
      @gateway = Gateway.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gateway_params
      params.require(:gateway).permit(:email, :password, :password_confirmation, :ip, :url_connection, :tag_list, product_attributes: [:name, :model, :serial_number, :mac_address, :product_code, :fabrication_date, :tension_operation, :node_id])
    end
end
