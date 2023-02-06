ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...
  def rand_username
    characters = [('0'..'9').to_a, ('a'..'z').to_a, ('A'..'Z').to_a].flatten
    username = ''

    12.times do
      username << characters.sample
    end
    username
  end
end
