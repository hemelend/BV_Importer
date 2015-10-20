class ImportedFilesController < ApplicationController
  require 'csv'
  before_action :authenticate_user!

  # GET imported_files/index
  def index
    # @mstats = MarketingStat.all
    @files = ImportedFile.all
  end

  # GET imported_files/new
  def new
    @new_file = ImportedFile.new
  end

  # POST imported_files/create
  def create
    filename = imported_file_params[:name].path
    file_extension = imported_file_params[:name].content_type
    if file_extension == 'application/gzip'
      Zlib::GzipReader.open(filename) do |gzip|
        csv = CSV.new(gzip)
        csv.each do |row|
          puts row.inspect
        end
      end
    elsif file_extension == 'application/zip'
      impfile = ImportedFile.create(imported_file_params)
      Zip::File.open(filename) do |zip_file|
        # Handle entries one by one
        zip_file.each do |entry|
          inserts = []
          if entry.directory?
            puts "#{entry.name} is a folder!"
          elsif entry.symlink?
            puts "#{entry.name} is a symlink!"
          elsif entry.file?
            puts "#{entry.name} is a regular file!"

            # Read into memory
            # content = entry.get_input_stream.read
            csv = CSV.new(entry.get_input_stream.read, headers:true)
            # Create array with data
            csv.each do |row|
              inserts.push "(#{row['policyID']}, '#{row['statecode']}-#{row['county']}-#{row['construction']}-#{row['line']}', #{row['point_granularity']}, #{row['eq_site_limit']}, #{impfile.id}, utc_timestamp(), utc_timestamp())"
            end
            # create chunk of 1000 records in order to improve performance
            (1..inserts.size).step(1000).each do |start|
              data = inserts[start-1..start+998]
              sql_insert_st = "INSERT INTO marketing_stats (`campaign_name`, `impressions`, `clicks`, `cost`, `imported_file_id`, `created_at`, `updated_at`) VALUES #{data.map {|rec| "#{rec}" }.join(", ")}"
              MarketingStat.connection.execute(sql_insert_st)
            end
          else
            puts "#{entry.name} is something unknown, oops!"
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to show_marketing_stats_path(impfile.id)}
    end
  end

  def destroy
    impfile = ImportedFile.find(params[:id]).destroy
    # impfile.marketing_stats.delele_all
    # impfile.destoy

    respond_to do |format|
      format.html { redirect_to imported_files_url }
      format.json { head :no_content }
    end
  end

  private

  def imported_file_params
    params.require(:imported_file).permit(:user_id, :name)
  end
end
