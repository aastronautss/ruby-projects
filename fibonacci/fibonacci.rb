def fibs(n)
  result = []
  n.times do |i|
    if i == 0 || i == 1
      result << 1
    else
      result << result[i - 1] + result[i - 2]
    end
  end

  result
end

def fibs_rec(n, a = 0, b = 1, result = [])
  n > 0 ? fibs_rec(n - 1, b, b + a, result << b) : result
end

p fibs(0)
p fibs(1)
p fibs(2)
p fibs(3)
p fibs(10)

p fibs_rec(0)
p fibs_rec(1)
p fibs_rec(2)
p fibs_rec(3)
p fibs_rec(10)
