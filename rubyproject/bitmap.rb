class BitMap
  @command = ""
  @counter = 0
  @arr_2d = "0{" "}"
  @row=0
  @col=0
  def horizontal
    col1 = @command[@counter + 1].to_i
    col2 = @command[@counter + 2].to_i
    row = @command[@counter + 3].to_i
    (col1 .. col2).each { | index |

      @arr_2d[row - 1][index - 1] = "Z"
    }
  end
  def vertical
    col  = @command[1 + @counter].to_i
    row1 = @command[@counter + 2].to_i
    row2 = @command[@counter + 3].to_i
    color  = @command[@counter + 4]
    (row1 .. row2).each { | index |
      @arr_2d[index - 1][col - 1] = color
    }
  end
  def init
    @row    = @command[@counter + 1].to_i
    @col    = @command[@counter + 2].to_i
    @arr_2d = Array.new(@col) { Array.new(@row, "O") }
  end
  def open(file)
    if File.zero?(file)
      print 'file is empty'

   else

    @command = File.open(file).read.delete(' ').upcase.to_s

    end
  end
  def show
    @arr_2d.each { | x |

      puts x.join(" ")


    }
  end
  def clear
    @arr_2d = Array.new(@row) { Array.new(@col, "O") }
  end
  def pixels
    @arr_2d[@command[@counter + 2].to_i - 1][@command[@counter + 1].to_i - 1] = "#{@command[@counter + 3]}"
  end
  def compute
    @counter=0
    while @counter <@command.length
      case @command[@counter]

       when "I"
       init
      when  "L"
      pixels
      when "C"
      clear
      when "S"
      show
      when "V"

      vertical
      when "H"
      horizontal
      end
      @counter += 1
  end
  end
end

obj=BitMap.new
obj.open("text.txt")
obj.compute()


