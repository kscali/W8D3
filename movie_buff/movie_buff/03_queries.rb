def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  # good_actors = Movie
  # .select(:title)
  # .joins(:actors)
  # .where('castings.ord = 1')
  # .distinct 

  # Movie
  # .select(:title, :id)
  # .joins(:actors)
  # .where('title IN (?) AND actors.name IN (?)', good_actors, those_actors)

  length = those_actors.length
  Movie
  .joins(:actors)
  .select(:title, :id)
  .where('actors.name IN (?)', those_actors)
  .group(:id)
  .having('COUNT(movies.id)=(?)', length)

  end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.select('(yr/10) * 10 AS decade').group('decade').order('AVG(score) DESC').first.decade

end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movies = Movie.select(:id).joins(:actors).where('actors.name = (?)', name)

  Actor.joins(:movies).where('movies.id IN (?) AND actors.name != (?)', movies, name).distinct.pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
  .left_outer_joins(:castings)
  .where('castings.movie_id IS NULL')
  .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  name = "%#{whazzername.split("").join('%')}%"
  Movie
    .select('*')
    .joins(:actors)
    .where('actors.name ILIKE (?)', name)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
  .select('MAX(movies.yr) - MIN(movies.yr) as career, actors.id, actors.name ')
  .joins(:movies)
  .group('actors.id')
  .order('career DESC')
  .limit(3)
end
