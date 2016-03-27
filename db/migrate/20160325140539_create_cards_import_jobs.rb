class CreateCardsImportJobs < ActiveRecord::Migration
  def change
    create_table :cards_import_jobs do |t|
      t.references :version, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
