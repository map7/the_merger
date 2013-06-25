require "the_merger/version"

module TheMerger
  #
  # Default settings for TheMerger
  # 
  # - merge_model:   User
  #

  def merge_fields(subject,original_body)
    parse_config
    
    @merge_model.constantize.all.each do |user|
      body = original_body.dup
      
      model_fields.each do |field|
        newbody = body.gsub!("[#{field}]", user.send(field))
        body = newbody unless newbody.nil?
      end

      # Send the emails
      mailer = TheMerger::Mailer.batch_mail("from@example.com", subject, body, user)
      mailer.deliver

    end
  end

  def field_selection
    body = select_tag :field, options_for_select(model_fields)
    body += button_tag "Insert", class: "insert_field"
    content_tag(:div, body, class: "merge_field")
  end

  def model_fields
    parse_config
    @merge_model.constantize.attribute_names.reject{|x| %w[created_at updated_at id].include?(x)}
  end
  
  private

  def parse_config
    path = "#{Rails.root}/config/the_merger.yml"
    
    if File.exists?(path)
      conf=YAML::load(IO.read(path))
      @merge_model = conf["merge_model"]
    else
      @merge_model = "User"
    end
  end  
end

require "the_merger/engine"
ActionView::Base.send :include, TheMerger
