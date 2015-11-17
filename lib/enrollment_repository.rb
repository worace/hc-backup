require "csv"
require "pry"

class EnrollmentRepository
  attr_reader :records

  def initialize
    @records = []
  end

  def load_data(data_files)
    kpath = data_files[:enrollment][:kindergarten]
    kparticipation = aggregate_district_data_from_file(kpath)
    records = kparticipation.map do |dist_name, participation|
      Enrollment.new({name: dist_name,
                      kindergarten_participation: participation})
    end

    add_records(records)
  end

  def aggregate_district_data_from_file(filepath)
    grouped = CSV.open(filepath, headers: true).group_by { |row| row["Location"] }
    by_dist_name = grouped.map do |dist_name, rows|
      by_year = rows.reduce({}) do |by_year, row|
        by_year[row["TimeFrame"].to_i] = row["Data"].to_f
        by_year
      end
      [dist_name, by_year]
    end.to_h
  end

  def add_records(records)
    @records += records
  end

  def find_by_name(name)
    records.find { |r| r.name == name }
  end
end
