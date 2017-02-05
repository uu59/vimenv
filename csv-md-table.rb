require "csv"


def display_width(str)
  return 0 unless str
  str.chars.map{|c| c.ascii_only? ? 1 : 2 }.inject(:+)
end

def md_to_csv(str)
  output = ""
  str.lines.each_with_index do |row, i|
    next if i == 1 # cols = "| ----- | -- |"
    _, *cols, _ = row.split("|")
    output << cols.map(&:strip).join("\t")
    output << "\n"
  end
  output
end

def csv_to_md(csv)
  output = ""
  col_width = {}
  rows = []
  col_sep = (csv.include?("\t") ? "\t" : ",")

  CSV.parse(csv, col_sep: col_sep) do |row|
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
  output
end

body = STDIN.read
output =
  if body.lines.find{|line| line.match(/^[\|\- ]*$/)}
    md_to_csv(body)
  else
    csv_to_md(body)
  end

puts output


__END__
col1,col2
ああ,e
いうあいうあ,e

col1,col2
ああ,e
いうあいうあ,e



