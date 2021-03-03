# frozen_string_literal: true

require_relative './lib/weblog_parser'
require_relative './lib/weblog_parser/errors'

if ARGV.empty?
    puts <<~INSTRUCTIONS
        Usage: parser.rb <file_path>
            file_path: the path to log file
    INSTRUCTIONS
    
    exit(0)
end

file_path, * = ARGV

begin
    puts WeblogParser.present(file_path)
rescue WeblogParser::Errors::Error => e  
    puts e.message
end
