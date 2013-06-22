require "the_merger/version"

module TheMerger
  #
  # Default settings for TheMerger
  # 
  # merge_model:   User
  #
  
  def self.merger
    puts 'Mail Merge test'
  end

  def self.merge_fields(original_body, *fields)
    self.parse_config
    
    @merge_model.constantize.all.each do |user|
      puts "User: #{user.firstname}"
      
      body = original_body.dup
      
      fields.each do |field|
        body = body.gsub!("[#{field}]", user.send(field))
        puts "body = #{body}"
      end
    end
  end

  def merge_fields
    fields=User.attribute_names.reject{|x| %w[created_at updated_at id].include?(x)}
    body = select_tag :field, options_for_select(fields)
    body += button_tag "Insert"
    content_tag(:div, body, class: "merge_field")
  end
  
  def self.model_fields
    self.parse_config
    @merge_model.constantize.attribute_names.reject{|x| %w[created_at updated_at id].include?(x)}
  end
  
  private

  def self.parse_config
    path = "#{Rails.root}/config/the_merger.yml"
    
    if File.exists?(path)
      conf=YAML::load(IO.read(path))
      @merge_model = conf["merge_model"]
    else
      @merge_model = "User"
    end
  end  
end

ActionView::Base.send :include, TheMerger
