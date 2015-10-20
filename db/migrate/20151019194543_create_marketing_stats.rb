class CreateMarketingStats < ActiveRecord::Migration
  def change
    create_table :marketing_stats do |t|
      t.string :campaign_name
      t.text :impressions
      t.integer :clicks
      t.float :cost
      t.references :imported_file, index: true

      t.timestamps null: false
    end
    add_foreign_key :marketing_stats, :imported_files
  end
end
