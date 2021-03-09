# frozen_string_literal: true

module WeblogParser
  module Errors
    Error = Class.new(StandardError)
    FileNotExistingError = Error.new('File does not exist.')
    InvalidLogFormatError = Error.new('Invalid logs format.')
  end
end
