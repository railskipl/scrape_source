require 'thread'
array = ["first", "second", "third", "fourth", "fifth"]

queue = Queue.new

producer = Thread.new do
  array.each do |e|
    queue << e
    puts "#{e} produced"
  end
end

producer = Thread.new do
  (queue.length).times do |i|
    value = queue.pop
    puts "#{value} has been popped!"
    puts value.inspect
  end
end

# consumer = Thread.new do
#   5.times do |i|
#     value = queue.pop
#     sleep rand(i/2) # simulate expense
#     puts "consumed #{value}"
#   end
# end

# # consumer.join