class User < ApplicationRecord

  def self.create_with_omniauth(auth)
    create! do |user|
      Rails.logger.info "-----------------------------------"
      Rails.logger.info "Executing User.create_with_omniauth."
      Rails.logger.info auth
      Rails.logger.info "-----------------------------------"
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['credentials']
        user.token = auth['credentials']['token']
        user.token_expires_at = Time.at(auth['credentials']['expires_at'])
      end

      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
        user.image = auth['info']['image'] || ""
      end
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

end