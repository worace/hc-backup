require_relative "district"
require_relative "enrollment_repository"

class DistrictRepository
  attr_reader :districts, :enrollment_repository
  def load_data(data_files)
    er = EnrollmentRepository.new
    er.load_data(data_files)
    @enrollment_repository = er
    create_districts_from_repos!
  end

  def create_districts_from_repos!
    d_names = enrollment_repository.records.map(&:name).uniq
    districts = d_names.map do |n|
      d = District.new({name: n})
      d.enrollment = enrollment_repository.find_by_name(n)
      d
    end

    # Created the districts
    # Now need to go through each district
    # and attach the correspond enrollment object
    @districts = districts
  end

  def load_repos(repos)
    @enrollment_repository = repos[:enrollment]
    create_districts_from_repos!
  end

  def find_all_matching(substring)
    districts.select do |d|
      d.name.include?(substring)
    end
  end

  def find_by_name(dname)
    districts.find { |d| d.name.upcase == dname.upcase }
  end
end
