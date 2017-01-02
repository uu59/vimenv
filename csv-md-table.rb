require "csv"

csv = STDIN.read
output = ""
col_width = {}
rows = []

def display_width(str)
  str.chars.map{|c| c.ascii_only? ? 1 : 2 }.inject(:+)
end

CSV.parse(csv, col_sep: ARGV.first || ",") do |row|
  row.each.with_index do |col, i|
    col_width[i] = [col_width[i], display_width(col)].compact.max
  end
  rows << row
end
max_width = col_width.max

rows.each.with_index do |row, ri|
  row.each.with_index do |col, ci|
    w = display_width(col)
    mw = col_width[ci]
    output << "| #{col}#{" " * (mw - w)} "
  end
  output << "|\n"
  if ri.zero?
    row.length.times.with_index do |_, i|
      output << "| #{"-" * col_width[i]} "
    end
    output << "|\n"
  end
end

puts output
