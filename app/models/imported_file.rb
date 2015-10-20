class ImportedFile < ActiveRecord::Base
  belongs_to :user
  has_many :marketing_stats, :dependent => :delete_all

  mount_uploader :name, ImpFileNameUploader

  validates_uniqueness_of :name
end
