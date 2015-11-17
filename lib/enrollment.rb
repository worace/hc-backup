class Enrollment
  attr_reader :name,
              :kindergarten_participation_by_year,
              :graduation_rate_by_year

  def initialize(data)
    @name = data[:name]
    @kindergarten_participation_by_year = truncated(data[:kindergarten_participation] || {})
    @graduation_rate_by_year = truncated(data[:high_school_graduation] || {})
  end

  def truncate(float)
    float.to_s[0..4].to_f
  end

  def truncated(hash)
    hash.map { |k,v| [k, truncate(v)] }.to_h
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation_by_year[year]
  end

  def graduation_rate_in_year(year)
    graduation_rate_by_year[year]
  end

  def average_kindergarten_participation
    kindergarten_participation_by_year.values.reduce(:+) / kindergarten_participation_by_year.length
  end

  def average_graduation_rate
    graduation_rate_by_year.values.reduce(:+) / graduation_rate_by_year.count
  end

end
