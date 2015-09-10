def merge_sort(ary)
  if ary.length == 1
    return ary
  else
    a, b = ary.each_slice(ary.length / 2).to_a
    a = merge_sort(a)
    b = merge_sort(b)
    merge(a, b)
  end
end

def merge(ary = [], a, b)
  until a.empty? || b.empty?
    ary << (a[0] < b[0] ? a.shift : b.shift)
  end
  ary += (a.empty? ? b : a)
end

sort_me = 100.times.map { rand(500) + 1 }
p merge_sort(sort_me)
