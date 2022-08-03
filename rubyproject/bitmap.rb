class BitMap
  attr_reader :command,:counter,:arr_2d,:row,:col
  def open_file(file)
    begin
      @command = open(file).read.split
    rescue Errno::ENOENT
      p 'File not found'
      exit
    else
      @command=@command.map(&:upcase)
      check_command
    end
  end
  def initialize_command
    @row    = @command[@counter + 1].to_i
    @col    = @command[@counter + 2].to_i

    if @col > 250 ||@row>250 && @col<1 ||@row<1
      print 'size out of the bound'
      exit
    else
      @arr_2d = Array.new(@col) { Array.new(@row, "O") }
    end
  end
  def check_command
    if @command[0] != "I"
      print 'command not initialize'
      exit
    end
    length_i=@command.count("I")
    if length_i > 1
      print 'more then 1 initializer '
      exit
    end
  end
  def set_pixels
    row = @command[@counter + 2].to_i-1
    col = @command[@counter + 1].to_i - 1
    color =@command[@counter + 3]
    if row > @row ||col > @col
      print "size of row is out of the bound"
    else
      @arr_2d[row][col] = "#{color}"
    end
  end
  def set_horizontal
    col1 = @command[@counter + 1].to_i
    col2 = @command[@counter + 2].to_i
    row = @command[@counter + 3].to_i
    if row-1>@row ||col1-1>@col||col2-1>@col
      print "size of matrix is out of the bound in horizontal"
      exit
    elsif col1>col2
      print 'column range size is not correct in horizontal'
      exit
    else
      (col1 .. col2).each { | index |

        @arr_2d[row-1 ][index-1 ] = "Z"
      }
    end
  end
  def set_vertical
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
  def continue
    # code here
  end
  def compute
    @counter=0
    while @counter <@command.length
      case @command[@counter]

      when "I"
        initialize_command
      when  "L"
        set_pixels
      when "C"
        clear
      when "S"
        show
      when "V"
        set_vertical
      when "H"
        set_horizontal
      end
      @counter += 1
    end
  end
  def show
    if @arr_2d.eql?nil
      print "nothing to show"
      exit
    else
      print'*******************************BITMAP CONVERTOR**********************************************'
      puts
      @arr_2d.each { | x |
        puts x.join(" ") }
      puts
    end
  end
  def clear
    @arr_2d = Array.new(@row) { Array.new(@col, "O") }
  end
end
bit_set=BitMap.new
bit_set.open_file("text.txt")
bit_set.compute
