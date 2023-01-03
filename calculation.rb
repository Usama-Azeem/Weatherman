# frozen_string_literal: true

require 'csv'
# This class calculate the Highest/Minimum Temperature and Humidity
class Calculation
  def initialize
    @maximum_temp = 0
    @minimum_temp = 0
    @maximum_humidity = 0
    @maximum_temp_date = ''
    @minimum_temp_date = ''
    @maximum_humidity_date = ''
  end

  def show_date(month, day)
    month_names = %w[January Febuary March April May June July
                     August September October November December]
    month1 = month_names[month - 1]
    month1 + " #{day}"
  end

  def getting_max_min(init_path)
    maximum_temperature(init_path)
    minimum_temperature(init_path)
    maximum_humidity(init_path)
  end

  def maximum_temperature(path)
    file = CSV.parse(File.read(path))
    file.each do |row|
      temperature_row = row[1].to_i

      if temperature_row > @maximum_temp
        @maximum_temp = temperature_row
        @maximum_temp_date = row[0].split('-')
      end
    end
  end

  def minimum_temperature(path)
    file = CSV.parse(File.read(path))
    file.each do |row|
      temperature_row = row[3].to_i
      next if temperature_row.to_s != row[3]

      if temperature_row < @minimum_temp
        @minimum_temp = temperature_row
        @minimum_temp_date = row[0].split('-')
      end
    end
  end

  def maximum_humidity(path)
    file = CSV.parse(File.read(path))
    file.each do |row|
      row_min_humid = row[7].to_i
      if row_min_humid > @maximum_humidity
        @maximum_humidity = row_min_humid
        @maximum_humidity_date = row[0].split('-')
      end
    end
  end

  def display_max_min_temp
    puts "Highest Temperature: #{@maximum_temp}" + 'C' " on #{show_date(@maximum_temp_date [1].to_i,
                                                                        @maximum_temp_date[2])}"
    puts "Lowest Temperature: #{@minimum_temp}" + 'C' " on #{show_date(@minimum_temp_date[1].to_i,
                                                                       @minimum_temp_date[2])}"
  end

  def display_max_humid
    puts "Highest Humid: #{@maximum_humidity}" + '%' " on  #{show_date(@maximum_humidity_date [1].to_i,
                                                                       @maximum_humidity_date [2])}"
  end
end

# This class calculate the Average Highest/Minimum Temperature and Humidity
class AverageCal
  def initialize
    @maximum_temp = 0
    @minimum_temp = 100
    @values_of_humidity = []
  end

  def getting_avg_temp(path)
    avg_max_temp(path)
    avg_humidity(path)
    avg_min_temp(path)
  end

  def avg_max_temp(path)
    file = CSV.parse(File.read(path))
    file.each do |row|
      temperature_row = row[2].to_i
      @maximum_temp = temperature_row if temperature_row > @maximum_temp
    end
  end

  def avg_humidity(path)
    file = CSV.parse(File.read(path))
    file.each do |row|
      row_mhumid = row[8].to_i
      @values_of_humidity << row_mhumid if row_mhumid.to_s == row[8]
    end
  end

  def avg_min_temp(path)
    file = CSV.parse(File.read(path))
    file.each do |row|
      temperature_row = row[2].to_i
      next if temperature_row.to_s != row[2]

      @minimum_temp = temperature_row if temperature_row < @minimum_temp
    end
  end

  def display_avg_temp
    puts "Highest Average: #{@maximum_temp}C"
    puts "Lowest Average: #{@minimum_temp}C"
    puts "Average Humidity: #{@values_of_humidity.sum / @values_of_humidity.count}%"
  end
end
