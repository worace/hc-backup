require "./lib/district"
require "minitest"
require "minitest/autorun"

class DistrictTest < Minitest::Test
  def test_its_a_district
    d  = District.new(name: "Denver")
    assert_equal "Denver", d.name
  end
end
