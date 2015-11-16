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
end
