class EnrollmentRepository
  attr_reader :records

  def initialize
    @records = []
  end

  def add_records(records)
    @records += records
  end

  def find_by_name(name)
    records.find { |r| r.name == name }
  end
end
