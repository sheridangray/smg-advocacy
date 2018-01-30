class TwilioController < ApplicationController

  # Before we allow the incoming request to connect, verify
  # that it is a Twilio request
  before_action :load_credentials, only: [:call, :connect]
  before_action :authenticate_twilio_request, only: [:connect]
  skip_before_action :verify_authenticity_token



  # Handle a POST from our web form and connect a call via REST API
  def call
    twilio_contact = TwilioContact.new
    twilio_contact.user_phone  = params[:userPhone]
    twilio_contact.target_phone = params[:targetPhone]

    # Validate contact
    if twilio_contact.valid?
      @client = Twilio::REST::Client.new @twilio_sid, @twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
        to:   twilio_contact.user_phone,
        from: Rails.application.secrets.twilio_phone_number,
        url: "https://salty-citadel-43320.herokuapp.com/connect/#{twilio_contact.encoded_target_phone}"
        # url: "http://localhost:3000/connect/1"
      )

      # Let's respond to the ajax call with some positive reinforcement
      @msg = { message: 'Phone call incoming!', status: 'ok' }
    else

      # Oops there was an error, lets return the validation errors
      @msg = { message: twilio_contact.errors.full_messages, status: 'ok' }
    end

    # respond_to do |format|
    #   format.json { render json: @msg }
    # end
    # format.json { render json: @msg }
    redirect_to user_path(current_user)
  end

  # This URL contains instructions for the call that is connected with a lead
  # that is using the web form.
  def connect
    Rails.logger.info "TwilioController.connect"
    # Our response to this request will be an XML document in the "TwiML"
    # format. Our Ruby library provides a helper for generating one
    # of these documents
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say('Thanks for contacting our sales department. Our '\
        'next available representative will take your call.', voice: 'alice')
      r.dial number: params[:target_phone]
    end


    render xml: response.to_s
  end

  # Authenticate that all requests to our public-facing TwiML pages are
  # coming from Twilio. Adapted from the example at
  # http://twilio-ruby.readthedocs.org/en/latest/usage/validation.html
  # Read more on Twilio Security at https://www.twilio.com/docs/security
  private

  def authenticate_twilio_request
    return true
    # if twilio_req?
    #   return true
    # else
    #   response = Twilio::TwiML::VoiceResponse.new do|r|
    #     r.hangup
    #   end

    #   render xml: response.to_s, status: :unauthorized
    #   false
    # end
  end

  def twilio_req?
    # Helper from twilio-ruby to validate requests.
    validator = Twilio::Security::RequestValidator.new(@twilio_token)

    # the POST variables attached to the request (eg "From", "To")
    # Twilio requests only accept lowercase letters. So scrub here:
    post_vars = params.reject { |k, _| k.downcase == k }
    twilio_signature = request.headers['HTTP_X_TWILIO_SIGNATURE']

    validator.validate(request.url, post_vars, twilio_signature)
  end

  def load_credentials
    # Define our Twilio credentials as instance variables for later use
    @twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_number = ENV['TWILIO_NUMBER']
    @api_host = ENV['API_HOST']
  end
end