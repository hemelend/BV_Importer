class MarketingStatsController < ApplicationController

  def index
  end

  def show
    @impfile = ImportedFile.find(params[:id])
    @mstats = Kaminari.paginate_array(@impfile.marketing_stats).page(params[:page] || 1).per(100)
  end
end
