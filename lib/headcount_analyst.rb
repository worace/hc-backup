class HeadcountAnalyst
  attr_reader :district_repository
  def initialize(dr)
    @district_repository = dr
  end

  def kindergarten_participation_rate_variation_of_enrollments(e1, e2)
    e2.average_kindergarten_participation / e1.average_kindergarten_participation
  end

  def kindergarten_participation_rate_variation(d1_name, options)
    d2_name = options[:against]
    dist_1 = district_repository.find_by_name(d1_name)
    dist_2 = district_repository.find_by_name(d2_name)

    kindergarten_participation_rate_variation_of_enrollments(dist_1.enrollment, dist_2.enrollment)
  end
end
