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
  #  group  (optional subset of users)
  #  single (optional single user)
  #
  def mail_merge(opts={})

    # Go through and get the collection to merge & send.
    if opts[:group]
      users = opts[:group]
    elsif opts[:single]
      users = [opts[:single]]
    else
      users = model.all
    end
    
    # Go through all users, merge & send.
    users.each {|user| merge_and_send(opts[:from], opts[:subject], opts[:body].dup, user)}
  end

  def merge_and_send(from,subject,body,user)
    # Merge fields for this user into the body
    body = merge_fields(body, user)
    
    # Send the emails
    TheMerger::Mailer.batch_mail(from, subject, body, user).deliver
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
