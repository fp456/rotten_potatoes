class Movie < ActiveRecord::Base
  def self.return_ratings
    ['G','PG','PG-13','R']
  end

  def self.checked_ratings params
    params.keys
  end

end