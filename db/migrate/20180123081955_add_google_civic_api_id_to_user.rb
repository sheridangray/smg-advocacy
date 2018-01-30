class AddGoogleCivicApiIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :google_civic_api, foreign_key: true
  end
end
