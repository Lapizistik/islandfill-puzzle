#!/usr/bin/ruby

class Island
  attr_reader :field
  def initialize(str)
    @width = (str =~ /$/) + 1
    @length = str.length
    @field = str
    i = 0
    @length.times {|pos| floodfill(pos,i.to_s) && i+=1 }
  end

  def floodfill(pos, c)
    if (0...@length).include?(pos) && @field[pos] == 'X'
      system('clear')
      puts @field
      $stdout.sync
      sleep(0.05)
      @field[pos] = c
      [pos-@width, pos-1, pos+1, pos+@width].each do |p|
        floodfill(p, c)
      end
      true
    end    
  end
end

if __FILE__==$0
  puts Island.new(DATA.read).field
end

__END__
..................................................
...XXXXXX.....XX.....XXXXXX....XXXXXX...XX....XX..
..XXX...XX..XXXX....XX....XX..XX....XX..XX....XX..
..XXXX..XX....XX..........XX........XX..XX....XX..
..XX.XX.XX....XX.....XXXXXX.....XXXXX...XXXXXXXX..
..XX..XXXX....XX....XX..............XX........XX..
..XX...XXX....XX....XX........XX....XX........XX..
...XXXXXX...XXXXXX..XXXXXXXX...XXXXXX.........XX..
..................................................
..................................................
..XXXXXXX....XXXXXX...XXXXXXXX..XXXXXX....XXXXXX..
..XX........XX....XX.......XX..XX....XX..XX....XX.
..XX........XX............XX...XX....XX..XX....XX.
..XXXXXXX...XXXXXXX......XX.....XXXXXX....XXXXXXX.
........XX..XX....XX....XX.....XX....XX........XX.
..XX....XX..XX....XX...XX......XX....XX..XX....XX.
...XXXXXX....XXXXXX...XX........XXXXXX....XXXXXX..
..................................................

