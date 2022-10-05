class Movie < ActiveRecord::Base
  def self.return_ratings
    ['G','PG','PG-13','R']
  end

  def self.checked_ratings(params)
    if params.empty?
      []
    else
      params.keys
    end
  end

  def self.with_ratings(ratings)
    if ratings.empty?
      Movie.all
    else
      Movie.where("rating = 'G'")
    end
  end

end