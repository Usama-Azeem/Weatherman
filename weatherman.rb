# frozen_string_literal: true

# require_relative 'Avgcalculation'
# module for weatherman
require 'csv'
require_relative 'calculation'
require_relative 'colorize'
# This Class runs the weatherman Program
class Weatherman
  case ARGV[0]
  when '-e'

    i = Calculation.new
    month_names = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    a = 1
    while a <= 12

      month = month_names[a - 1]
      path = "#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1]}_#{month}.txt"
      CSV.parse(File.read(path))
      i.getting_max_min(path)
      a += 1
    end

    i.display_max_min_temp
    i.display_max_humid

  when '-a'

    index_of_month = ARGV[1].split('/')[1].to_i - 1
    months_names = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    month_names1 = %w[January February March April May June July August September October November December]
    month = months_names[index_of_month]
    path = "#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1].split('/')[0]}_#{month}.txt"
    average = AverageCal.new
    puts "#{month_names1[ARGV[1].split('/')[1].to_i - 1]} #{ARGV[1].split('/')[0]}"
    average.getting_avg_temp(path)
    average.display_avg_temp

  when '-c'

    index_of_month = ARGV[1].split('/')[1].to_i - 1
    months_names = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    month_names1 = %w[January February March April May June July August September October November December]
    month = months_names[index_of_month]
    path = "#{ARGV[2]}/#{ARGV[2]}_#{ARGV[1].split('/')[0]}_#{month}.txt"
    CSV.parse(File.read(path))
    colorize_obj = ColorizeText.new
    high_temp_list = colorize_obj.calc_max_temp(path)
    low_temp_list = colorize_obj.calc_min_temp(path)
    puts "#{month_names1[ARGV[1].split('/')[1].to_i - 1]} #{ARGV[1].split('/')[0]}"
    colorize_obj.colorize_display(high_temp_list, low_temp_list)
  end
end
