# frozen_string_literal: true

module Devise
  module CodeConfirmable
    ##
    # Generates a human readable confirmation code as per +code_generator+ or +code_alphabet+ and +code_length+ and
    # stores it in +confirmation_token+.
    ##
    module Models
      include Devise::Models::Confirmable

      protected

      def generate_confirmation_token
        if confirmation_token && !confirmation_period_expired?
          @raw_confirmation_token = confirmation_token
        else
          self.confirmation_token = @raw_confirmation_token = generated_code
          self.confirmation_sent_at = Time.now.utc
        end
      end

      def generated_code
        generator = code_generator
        return generator.call self if generator.respond_to?(:call)

        alphabet = klass.code_alphabet || Devise.code_alphabet
        length = klass.code_length || Devise.code_length
        code = alphabet.to_a.sample(length).join
        klass.code_case_insensitive ? code.upcase : code
      end

      def code_generator
        klass.code_generator || Devise.code_generator
      end

      module ClassMethods # :nodoc:
        Devise::Models.config(self, :code_generator, :code_alphabet, :code_length, :code_case_insensitive)
      end
    end
  end
end
