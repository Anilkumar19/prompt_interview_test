class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = current_user.organizations.all.paginate(:page => params[:page], :per_page => 10)
    @organization = Organization.new
    
    if current_user.is_admin
      render 'users/show'
    else
      unless @organizations.present?
        render :new
      end
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @user = current_user
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    @user = current_user
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @user = current_user
    @user.first_name = params[:organization][:user][:first_name]
    @user.last_name = params[:organization][:user][:last_name]
    @organization.user_id = current_user.id

    respond_to do |format|
      if @user.save && @organization.save 
        format.html { redirect_to @organization }
        #notice: 'Organization was successfully created.'
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    @user = current_user
    @user.first_name = params[:organization][:user][:first_name]
    @user.last_name = params[:organization][:user][:last_name]

    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :org_identifier, :user_id, :address_line1, :address_line2, :city, :state, :country, :zipcode)
    end
end
