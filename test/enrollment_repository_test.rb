require "./lib/enrollment_repository"
require "minitest"
require "minitest/autorun"

class EnrollmentRepositoryTest < Minitest::Test
  def test_loads_data
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv"
                   }
                 })
    assert er.find_by_name("ACADEMY 20")
  end

  def test_loads_grad_data
    er = EnrollmentRepository.new
    er.load_data({:enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    e = er.find_by_name("ACADEMY 20")
    expected = {2010=>0.895, 2011=>0.895, 2012=>0.889, 2013=>0.913, 2014=>0.898}
    assert_equal expected, e.graduation_rate_by_year
  end
end
