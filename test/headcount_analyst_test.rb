require "minitest"
require "minitest/autorun"
require "./lib/district_repository"
require "./lib/headcount_analyst"
require "./lib/enrollment"
require "./lib/enrollment_repository"

class HeadcountAnalystTest < Minitest::Test
  def test_it_compares_kindergarten_rates_across_districts
    e1 = Enrollment.new({:name => "Dist 1",
                         :kindergarten_participation => {2010 => 1.0}})
    e2 = Enrollment.new({:name => "Dist 2",
                         :kindergarten_participation => {2010 => 1.0}})

    er = EnrollmentRepository.new
    er.add_records([e1, e2])

    dr = DistrictRepository.new
    dr.load_repos({:enrollment => er})

    ha = HeadcountAnalyst.new(dr)

    rate = ha.kindergarten_participation_rate_variation("Dist 1", :against => "Dist 2")
    assert_equal 1.0, rate
  end

  def test_it_compares_kindergarten_rates_across_enrollments
    e1 = Enrollment.new({:name => "Dist 1",
                         :kindergarten_participation => {2010 => 0.5}})
    e2 = Enrollment.new({:name => "Dist 2",
                         :kindergarten_participation => {2010 => 1.0}})

    dr = DistrictRepository.new
    ha = HeadcountAnalyst.new(dr)
    rate = ha.kindergarten_participation_rate_variation_of_enrollments(e1, e2)
    assert_equal 0.5, rate
  end

  def test_kindergarten_against_hs
    e1 = Enrollment.new({:name => "Dist 1",
                         :kindergarten_participation => {2010 => 1.0},
                         :high_school_graduation => {2010 => 1.0}})
    e2 = Enrollment.new({:name => "COLORADO",
                         :kindergarten_participation => {2010 => 1.0},
                         :high_school_graduation => {2010 => 1.0}})
    er = EnrollmentRepository.new
    er.add_records([e1, e2])
    dr = DistrictRepository.new
    dr.load_repos({:enrollment => er})

    ha = HeadcountAnalyst.new(dr)

    rate = ha.kindergarten_participation_against_high_school_graduation("Dist 1")
  end

  def test_correlating_high_school_grad_with_kindergarten
    e1 = Enrollment.new({:name => "Dist 1",
                         :kindergarten_participation => {2010 => 1.0},
                         :high_school_graduation => {2010 => 1.0}})
    e2 = Enrollment.new({:name => "COLORADO",
                         :kindergarten_participation => {2010 => 1.0},
                         :high_school_graduation => {2010 => 1.0}})

    er = EnrollmentRepository.new
    er.add_records([e1, e2])

    dr = DistrictRepository.new
    dr.load_repos({:enrollment => er})

    ha = HeadcountAnalyst.new(dr)

    correlation = ha.kindergarten_participation_correlates_with_high_school_graduation("Dist 1")
    assert correlation
  end
end
