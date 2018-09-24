class Main
  def read
    puts 'Write path of file'
    text = File.open(gets.chomp , 'r'){ |file| file.read }
    text.split(/\W+/)
  end

  def parse(array_data)
    array_data.each_index do |i|
      if array_data[i] == 'FC'
        array_data[i + 1] = array_data[i] + ' ' + array_data[i + 1]
      end
    end
    array_data.delete('FC')
    result = {}
    (0...array_data.length).step(4).each do |i|
      unless result.key? array_data[i]
        result[array_data[i]] = 0
      end
      unless result.key? array_data[i + 2]
        result[array_data[i + 2]] = 0
      end
      if array_data[i + 1].to_i > array_data[i + 3].to_i      #win first team
        result[array_data[i].to_s] += 3
      elsif array_data[i + 1].to_i < array_data[i + 3].to_i   #win second team
        result[array_data[i + 2].to_s] += 3
      elsif array_data[i + 1].to_i == array_data[i + 3].to_i  #no win
        result[array_data[i].to_s] += 1
        result[array_data[i + 2].to_s] += 1
      end
    end
    result = result.sort_by { |k, v| k }
    result.sort_by{ |k, v| -v }
  end

  def write(result)
    result.each do |k, v|
      print "#{k}, #{v.to_s} #{ v!= 1 ? 'pts' : 'pt' }\n"
    end
  end

  def start
    file = read
    parsed = parse file
    write parsed
  end
end

main = Main.new
main.start
