require 'csv'

class MoviesJob
  include Sidekiq::Job

  def perform(csv_path)
    CSV.foreach(csv_path, headers: true) do |row|
      begin
        Movie.create(title: row['title'], director: row['director'])
      rescue => except
        puts except
      end
    end
  end
end
