require "lita"
require 'pry'

module Lita
  module Handlers
    class Claims < Handler
      PROPERTY_OR_ENVIRONMENT = /[\w\-]+/

      route(/^claim\s(#{PROPERTY_OR_ENVIRONMENT.source})(?:\s(#{PROPERTY_OR_ENVIRONMENT.source}))?/i, :create, command: true, help: {
        "claim PROPERTY" => "To claim a property by the name PROPERTY"
      })

      def create(response)
        claimer = response.message.source.user.name
        property, environment = response.matches.first
        environment ||= 'default'
        environment_string = " (#{environment})" if environment != 'default'
        if property && Claim.create(property, claimer, environment)
          reply = "#{property}#{environment_string} was claimed by #{claimer}"
        else
          existing_claimer = Claim.read(property, environment)
          reply = "Could not claim #{property}#{environment_string} - already claimed by #{existing_claimer}"
        end
        response.reply(reply)
      end
    end

    Lita.register_handler(Claims)
  end
end
