require "the_merger/version"

module TheMerger
  def self.merger
    puts 'Mail Merge test'
  end

  def self.merge_fields(*fields)
    fields.each do |field|
      puts field
    end
  end
  
end
