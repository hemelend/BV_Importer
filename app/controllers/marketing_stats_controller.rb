class MarketingStatsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @impfile = ImportedFile.find(params[:id])
    @mstats = Kaminari.paginate_array(@impfile.marketing_stats).page(params[:page] || 1).per(100)
  end

  def edit
    @mstat = MarketingStat.find(params[:id])
  end

  def update
    @mstat = MarketingStat.find(params[:id])
    file = @mstat.imported_file.id
    if @mstat.update_attributes(marketing_stat_params)
      redirect_to show_marketing_stats_path(file), notice: 'Data was successfully updated.'
    else
      redirect_to edit_marketing_stat_path(@mstat), alert: 'Data was unable to be updated.'
    end

  end

  def destroy
    data = MarketingStat.find(params[:id])
    file = data.imported_file.id
    data.destroy

    respond_to do |format|
      format.html { redirect_to show_marketing_stats_path(file), notice: 'Data was successfully removed from database.' }
      format.json { head :no_content }
    end
  end

  private

  def marketing_stat_params
    params.require(:marketing_stat).permit(:campaign_name, :impressions, :clicks, :cost)
  end
end
