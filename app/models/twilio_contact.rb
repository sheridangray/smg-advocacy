# Simple model to handle validation
class TwilioContact
  include ActiveModel::Validations
  attr_accessor :user_phone
  attr_accessor :target_phone
  validates_presence_of :user_phone
  validates_presence_of :target_phone

  def encoded_target_phone
    URI.encode(target_phone)
  end
end