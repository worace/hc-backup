class HeadcountAnalyst
  attr_reader :district_repository
  def initialize(dr)
    @district_repository = dr
  end

  def kindergarten_participation_rate_variation_of_enrollments(e1, e2)
    e1.average_kindergarten_participation / e2.average_kindergarten_participation
  end

  def kindergarten_participation_rate_variation(d1_name, options)
    d2_name = options[:against]
    dist_1 = district_repository.find_by_name(d1_name)
    dist_2 = district_repository.find_by_name(d2_name)

    kindergarten_participation_rate_variation_of_enrollments(dist_1.enrollment, dist_2.enrollment).round(3)
  end

  def graduation_rate_variation_of_enrollments(e1, e2)
    e1.average_graduation_rate / e2.average_graduation_rate
  end

  def graduation_rate_variation(d1_name, options)
    d2_name = options[:against]
    dist_1 = district_repository.find_by_name(d1_name)
    dist_2 = district_repository.find_by_name(d2_name)

    graduation_rate_variation_of_enrollments(dist_1.enrollment, dist_2.enrollment).round(3)
  end

  def kindergarten_participation_against_high_school_graduation(dname)
    k_variation = kindergarten_participation_rate_variation(dname, against: "COLORADO")
    h_variation = graduation_rate_variation(dname, against: "COLORADO")
    k_variation / h_variation
  end

  def kindergarten_participation_correlates_with_high_school_graduation(dname)
    comparison = kindergarten_participation_against_high_school_graduation(dname)
    comparison > 0.6 && comparison < 1.5
  end
end
