#!/usr/bin/ruby

class Island
  attr_reader :field
  def initialize(str)
    @field = str.lines.map { |line| line.chomp.chars }
    numberize # this modifies field!
    renumber # this too
  end

  def [](x,y)
    if x<0 || y<0
      '.'
    else
      @field.dig(y,x) || '.'
    end
  end

  def []=(x,y,v)
    @field[y][x] = v
  end
  
  def numberize
    @nr = 10
    @map = {}
    @order = []
    @field.each_with_index do |row, y|
      row.each_with_index do |c,x|
        if c == ?X
          self[x,y] = to_num(self[x,y-1], self[x-1, y])
        end
      end
    end
  end

  def renumber
    dests = (@order & @map.values.uniq).each_with_index.to_h
    @field.map! { |row|
      row.map { |c|
        dests[@map[c] || c] || c
      }.join
    }.join("\n")
  end
    
  def to_num(t, l)
    case [t,l]
    in ['.','.']
      (@nr += 1).tap { @order << @nr }
    in ['.',n]
      n
    in [n,'.']
      n
    in [n,m]
      if n == m
        n
      else
        @map[m] = @map[n] || n
      end
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
