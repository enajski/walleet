class Api::V1::GroupsController < ApplicationController
  respond_to :json

  def index
    respond_with Group.all
  end
end
