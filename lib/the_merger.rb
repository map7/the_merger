require "the_merger/version"

module TheMerger
  def self.merger
    puts 'Mail Merge test'
  end
  
  def self.merge_fields(original_body, *fields)

    User.all.each do |user|
      puts "User: #{user.firstname}"
      
      body = original_body.dup
      
      fields.each do |field|
        body = body.gsub!("[#{field}]", user.send(field))
        puts "body = #{body}"
      end
    end
  end

  
end
