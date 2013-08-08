class TheMerger::Mailer < ActionMailer::Base
    
  def batch_mail(from,subject,body,person)
    mail(from: from, 
         to: person.email,
         subject: subject) do |format|
      format.html {body.html_safe}
      format.text {body}      
    end
  end  
end
