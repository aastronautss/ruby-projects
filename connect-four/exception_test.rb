def prompt_user
  s = gets.chomp
  raise "Penis" unless s == "hi"
  s
end

begin
  a = prompt_user
rescue Exception => exc
  puts "Excption: #{exc}"
end

puts "Got here"
