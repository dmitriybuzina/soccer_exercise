require 'pry'

class Main
  def read
    puts 'Write path of file'
    text = File.open(gets.chomp , 'r'){ |file| file.read }
    text.split(/\W+/)
  end
  def parse(chars)
    chars.each_index do |i|
      if chars[i] == 'FC'
        chars[i+1] = chars[i] + ' ' + chars[i+1]
      end
    end
    chars.delete('FC')
    result = {}
    i = 0
    while i < chars.length - 1
      unless result.key? chars[i]
        result[chars[i]] = 0
      end
      unless result.key? chars[i+2]
        result[chars[i+2]] = 0
      end
      if chars[i+1].to_i > chars[i+3].to_i      #win first team
        result[chars[i].to_s] += 3
      elsif chars[i+1].to_i < chars[i+3].to_i   #win second team
        result[chars[i+2].to_s] += 3
      elsif chars[i+1].to_i == chars[i+3].to_i  #no win
        result[chars[i].to_s] += 1
        result[chars[i+2].to_s] += 1
      end
      i += 4
    end
    result.sort_by{|k,v| v}
  end
  def write(result)
    i = result.length - 1
    while i >= 0
      if result[i][1] != 1
        print result[i][0] + ', ' + result[i][1].to_s + ' pts' + "\n"
      else
        print result[i][0] + ', ' + result[i][1].to_s + ' pt' + "\n"
      end
      i -= 1
    end
  end
  def start
    write(parse(read))
  end
end
main = Main.new
main.start
