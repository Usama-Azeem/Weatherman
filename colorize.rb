# frozen_string_literal: true

require 'colorize'
# class to display horizontal lines using gem
class ColorizeText
  def calc_max_temp(file)
    table = CSV.parse(File.read(file), headers: true)
    daily_maxtemp = table.by_col[1]
    daily_maxtemp.map!(&:to_i)
    daily_maxtemp
  end

  def calc_min_temp(file)
    table = CSV.parse(File.read(file), headers: true)
    daily_mintemp = table.by_col[3]
    daily_mintemp.map!(&:to_i)
    daily_mintemp
  end

  def task3(max_temp, min_temp)
    index = 1
    (max_temp.length - 2).times do
      print index
      max_temp[index].times { print '+'.red }
      print "#{max_temp[index]}C\n#{index}"
      min_temp[index].times { print '+'.blue }
      print "#{min_temp[index]}C\n"
      index += 1
    end
  end

  def task4(min_temp, max_temp)
    index = 1
    (max_temp.length - 2).times do
      print index
      max_temp[index].times { print '+'.blue }
      min_temp[index].times { print '+'.red }
      print "#{max_temp[index]}C - #{min_temp[index]}C\n"
      index += 1
    end
  end

  def colorize_display(min_temp, max_temp)
    task3(min_temp, max_temp)
    puts "\n Bonus Task Started \n"
    task4(min_temp, max_temp)
  end
end
