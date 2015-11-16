require "./lib/district_repository"
require "minitest"
require "minitest/autorun"

class DistrictRepositoryTest < Minitest::Test
  def test_it_loads_bunch_of_data
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv"
                   }
                 })

    assert_equal "ACADEMY 20", dr.find_by_name("ACADEMY 20").name
  end
end
