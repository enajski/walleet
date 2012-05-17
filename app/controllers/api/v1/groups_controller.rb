class Api::V1::GroupsController < ApplicationController
  respond_to :json

  def index
    respond_with Group.all
  end

  def create
    respond_with(Group.create(params[:group]), :location => "")
  end
  
  def destroy
    Group.find(params[:id]).destroy
    redirect_to api_v1_groups_path
  end
end
