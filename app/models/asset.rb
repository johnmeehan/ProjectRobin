# == Schema Information
#
# Table name: assets
#
#  id           :integer          not null, primary key
#  asset        :string
#  ticket_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_type :string
#

class Asset < ActiveRecord::Base
  belongs_to :ticket

  mount_uploader :asset, AssetUploader

  before_save :update_content_type

  private

  def update_content_type
    if asset.present? && asset_changed?
      self.content_type = asset.file.content_type
    end
  end
end
