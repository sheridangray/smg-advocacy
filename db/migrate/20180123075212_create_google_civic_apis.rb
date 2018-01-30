class CreateGoogleCivicApis < ActiveRecord::Migration[5.0]
  def change
    create_table :google_civic_apis do |t|

      t.timestamps
    end
  end
end
