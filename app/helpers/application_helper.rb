require 'tempfile'
require 'securerandom'
require 'csv'

module ApplicationHelper
    def save_file_temp_csv(file)
        filename = SecureRandom.uuid.to_s
        extension = '.csv'

        temp_file = Tempfile.new([filename, extension], 'tmp/')
        temp_file.binmode
        temp_file.write(file.read)
        temp_file.rewind

        "#{Rails.root.join(temp_file.path)}"
    end

    def csv_has_headers?(csv_path, expected_headers)
        headers = File.open(csv_path, &:gets)
        return false if headers.nil?

        csv_headers = CSV.parse_line(headers)
        expected_headers.sort == csv_headers.sort
    end
end
