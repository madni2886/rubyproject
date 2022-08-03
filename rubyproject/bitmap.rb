class BitMap
  def initialize
    super
    @command = ""
    @counter = 0
    @arr_2d = "0{" "}"
    @row=0
    @col=0
  end

  def init
    @row    = @command[@counter + 1].to_i
    @col    = @command[@counter + 2].to_i

    if @col > 250 ||@row>250 && @col<1 ||@row<1
      print 'size out of the bound'
      exit
    else
      @arr_2d = Array.new(@col) { Array.new(@row, "O") }


    end
  end
  def exception
    if @command[0] != "I"
      print 'command not initialize'
      exit


    end
    length_i=@command.count("I")
    length_h=@command.count("H")
    length_v=@command.count("V")
    if length_i > 1||length_h > 1||length_v > 1
      print 'more then 1 initializer '
      exit
    end
  end
  def open(file)
    if !File.exist?(file)
      print "File is not correct"
    elsif File.zero?(file)
      print 'file is empty'

    else

      @command = File.open(file).read.split
      @command=@command.map(&:upcase)
      exception

    end
  end
  def show
    if @arr_2d.length == 0
      print "nothing to show"
    else
      @arr_2d.each { | x |

        puts x.join(" ")


      }
    end

  end
  def clear

    @arr_2d = Array.new(@row) { Array.new(@col, "O") }
  end
  def pixels
    row = @command[@counter + 2].to_i-1
    col = @command[@counter + 1].to_i - 1
    color =@command[@counter + 3]
    if row > @row ||col > @col
      print "size of row is out of the bound"
    else
      @arr_2d[row][col] = "#{color}"
    end

  end
  def horizontal
    col1 = @command[@counter + 1].to_i
    col2 = @command[@counter + 2].to_i
    row = @command[@counter + 3].to_i
    if row-1>@row ||col1-1>@col||col2-1>@col
      print "size of matrix is out of the bound in horizontal"
      exit
    elsif col1>col2
      print 'column range size is not correct in horizontal'
      exit()
    else
      (col1 .. col2).each { | index |

        @arr_2d[row-1 ][index-1 ] = "Z"
      }
    end
  end
  def vertical
    col  = @command[1 + @counter].to_i-1
    row1 = @command[@counter + 2].to_i-1
    row2 = @command[@counter + 3].to_i-1
    color  = @command[@counter + 4]

    if row1>@row ||col>@col||row2>@row
      print "size of matrix is out of the bound in vertical"
      exit
    elsif row1>row2
      print 'row 1 size is greater then row 2 in vertical '
      exit
    else
      (row1 .. row2).each { | index |
        @arr_2d[index ][col ] = color
      }
    end
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
bit_set=BitMap.new
bit_set.open("text.txt")
bit_set.compute
