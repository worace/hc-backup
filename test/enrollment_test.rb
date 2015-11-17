require "./lib/enrollment"
require "minitest"
require "minitest/autorun"

class EnrollmentTest < Minitest::Test
  def test_basic_enrollment_methods
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    kdata = { 2010 => 0.391, 2011 => 0.353, 2012 => 0.267}
    assert_equal kdata, e.kindergarten_participation_by_year
  end

  def test_grad_rates
    e = Enrollment.new({:name => "ACADEMY 20",
                        :high_school_graduation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    gdata = { 2010 => 0.391, 2011 => 0.353, 2012 => 0.267}
    assert_equal gdata, e.graduation_rate_by_year
    assert_equal 0.353, e.graduation_rate_in_year(2011)
  end

  def test_avg_grad_rate
    e = Enrollment.new({:name => "ACADEMY 20",
                        :high_school_graduation => {2010 => 0.75,
                                                    2011 => 0.25}})
    assert_equal 0.50, e.average_graduation_rate
  end

end
