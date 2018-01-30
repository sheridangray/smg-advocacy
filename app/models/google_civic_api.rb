class GoogleCivicApi < ApplicationRecord

  attr_accessor :data

  def self.find_representative_by_address(address)
    HTTParty.get( 
      "https://www.googleapis.com/civicinfo/v2/representatives?key=
      #{Rails.application.secrets.google_api_key}&address=#{address}",
     :headers =>{'Content-Type' => 'application/json'} 
    )
  end
end
