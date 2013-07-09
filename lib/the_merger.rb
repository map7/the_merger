require "the_merger/version"

module TheMerger
  #
  # Default settings for TheMerger
  # 
  # - merge_model:   User
  #

  #
  # Merge the fields into the body and send emails
  #
  # Options;
  #  from
  #  subject
  #  body
  #  group (optional subset)
  #
  def mail_merge(options={})
    group = options[:group] ? options[:group] : model.all
    
    # For all users
    group.each do |user|
      
      # Merge fields for this user into the body
      body = merge_fields(options[:body].dup, user)
      
      # Send the emails
      TheMerger::Mailer.batch_mail(options[:from], options[:subject], body, user).deliver
    end
  end

  #
  # Replace fields which are in square brackets with data from the chosen model.
  #
  def merge_fields(body,user)
    fields.each do |field|
      body = body.gsub!("[#{field}]", user.send(field).to_s) || body
    end
    body
  end

  #
  # View Helper method (Optional)
  #
  # Selection box with fields from your model and an insert button
  #
  def field_selection
    body = select_tag :field, options_for_select(fields)
    body += button_tag "Insert", class: "insert_field"
    content_tag(:div, body, class: "merge_field")
  end

  #
  # Return all the fields from your configured model except created_at, updated_at & id
  #
  def fields
    model.attribute_names.reject{|x| %w[created_at updated_at id].include?(x)}
  end
  
  private

  def model
    if File.exists?(path = "#{Rails.root}/config/the_merger.yml")
      conf=YAML::load(IO.read(path))
      conf["merge_model"].constantize
    else
      User
    end
  end  
end

require "the_merger/engine"
ActionView::Base.send :include, TheMerger
