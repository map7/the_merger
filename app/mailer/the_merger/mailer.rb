class TheMerger::Mailer < ActionMailer::Base
    
  def batch_mail(from,subject,body,person)
    mail(from: from, 
         to: person.email,
         subject: subject) do |format|
      format.text {body}      
      format.html {body.html_safe}
    end
  end  
end
