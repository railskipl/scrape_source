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


      # threads << Thread.new do
      #   job_doc     = Nokogiri::HTML(open(job_url))
      #   title       = job_doc.css(args[:title_selector]).inner_text.strip
      #   company     = job_doc.css(args[:company_selector]).inner_text.strip
      #   source      = self.source
      #   job_url     = job_url.strip
      #   location    = job_doc.css(args[:location_selector]).inner_text.strip
      #   job_type    = job_doc.css(args[:job_selector]).inner_text.strip
      #   telecommute = "Empty for now"
      #   description = job_doc.css(args[:description_selector]).inner_text.strip

      #   self.job_database.insert_row([title, source, job_url, company, location, job_type, telecommute, description])
      # end
        # self.database.execute("INSERT INTO jobs (title, source, job_url, company, location, job_type, telecommute, description) 
        #                                     VALUES (?, ?, ?, ?, ?, ?, ?, ?);", [args])

    # threads.each(&:join)