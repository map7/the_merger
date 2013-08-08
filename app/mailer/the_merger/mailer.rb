class TheMerger::Mailer < ActionMailer::Base
  require 'redcarpet'           # Markdown to HTML
  
  def batch_mail(from,subject,body,person)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    
    mail(from: from, 
         to: person.email,
         subject: subject) do |format|
      format.text {body}      
      format.html {markdown.render(body).html_safe}
    end
  end  
end
