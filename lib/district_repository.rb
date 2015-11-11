require "./lib/district"

class DistrictRepository
  attr_reader :districts, :enrollment_repository
  def load_data(hash_o_files)
    # load all the files
    # make all the data
    # etc etc
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

  def find_by_name(dname)
    districts.find { |d| d.name == dname }
  end
end
