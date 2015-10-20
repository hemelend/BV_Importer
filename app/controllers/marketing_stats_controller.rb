class MarketingStatsController < ApplicationController

  def index
  end

  def show
    ms = ImportedFile.find(params[:id]).marketing_stats
    @mstats = Kaminari.paginate_array(ms).page(params[:page] || 1).per(100)
  end
end
