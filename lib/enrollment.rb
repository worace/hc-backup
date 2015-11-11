class Enrollment
  attr_reader :name, :kindergarten_participation_by_year

  def initialize(data)
    @name = data[:name]
    @kindergarten_participation_by_year = data[:kindergarten_participation]
  end

  def average_kindergarten_participation
    kindergarten_participation_by_year.values.reduce(:+) / kindergarten_participation_by_year.length
  end

end
