# frozen_string_literal: true

require 'devise'
require_relative 'code_confirmable/version'

module Devise # :nodoc:
  module CodeConfirmable
    # Holds configuration options and their defaults used by the +CodeConfirmable+ module
    module Configuration
      # Callable that generates a confirmation code. Overrides +code_alphabet+ and +code_length+ when set.
      # The callable receives the model instance as an argument.
      # Defaults to +nil+ which means the code will be generated using +code_alphabet+ and +code_length+.
      mattr_accessor :code_generator
      @code_generator = nil

      # Alphabet used to generate the confirmation code. Must respond to +#to_a+ (e.g. Range or Array).
      # The characters will be sampled randomly to generate the confirmation code.
      # Defaults to digits 0-9.
      mattr_accessor :code_alphabet
      @code_alphabet = (0..9)

      # Length of the confirmation code. Must be a positive integer.
      # Defaults to 6.
      mattr_accessor :code_length
      @code_length = 6
    end
  end

  include CodeConfirmable::Configuration
end
