class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authorize_admin!
  def index
  end
end
