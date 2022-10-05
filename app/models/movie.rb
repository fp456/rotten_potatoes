class Movie < ActiveRecord::Base
  def self.return_ratings
    ['G','PG','PG-13','R']
  end

  def self.checked_ratings params
    keys = params.keys
    if keys.empty?
      []
    else
      keys
  end

  def self.with_ratings ratings
    if ratings.empty?
      Movie.all
    else
      Movie.where("rating = 'G'")
  end

end