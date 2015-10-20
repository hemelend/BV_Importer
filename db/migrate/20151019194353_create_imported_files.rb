class CreateImportedFiles < ActiveRecord::Migration
  def change
    create_table :imported_files do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :imported_files, :users
  end
end
