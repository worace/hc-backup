require "csv"
require "pry"
require_relative "enrollment"

class EnrollmentRepository
  attr_reader :records

  def initialize
    @records = []
  end

  def load_data(data_files)
    k_data = aggregate_district_data_from_file(data_files[:enrollment][:kindergarten])
    h_data = aggregate_district_data_from_file(data_files[:enrollment][:high_school_graduation])

    all_districts = (k_data.keys + h_data.keys).uniq

    records = all_districts.map do |dname|
      Enrollment.new({:kindergarten_participation => k_data.fetch(dname, {}),
                      :high_school_graduation => h_data.fetch(dname, {}),
                      :name => dname})
    end

    add_records(records)
  end

  def aggregate_district_data_from_file(filepath)
    return {} unless filepath
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
