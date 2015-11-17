require "./lib/enrollment"
require "minitest"
require "minitest/autorun"

class EnrollmentTest < Minitest::Test
  def test_basic_enrollment_methods
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    kdata = { 2010 => 0.391, 2011 => 0.353, 2012 => 0.267}
    assert_equal kdata, e.kindergarten_participation_by_year
  end

end
