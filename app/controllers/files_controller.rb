class FilesController < ApplicationController
  before_filter :require_signin!

  def new
    new_file
    asset = @ticket.assets.build
    render partial: 'files/form', locals: { number: params[:number].to_i, asset: asset }
  end

  def show
    asset = get_asset
    if can?(:view, asset.ticket.project)
      send_file asset.asset.path, filename: asset.asset_identifier, content_type: asset.content_type
    else
      flash[:alert] = 'The asset you were looking for could not be found.'
      redirect_to root_path
    end
  end

  private

  def new_file
    @ticket  = Ticket.new
  end

  def get_asset
    Asset.find(params[:id])
  end
end
