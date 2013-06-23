class TheMerger::Mailer < ActionMailer::Base
    
  def batch_mail(from,subject,body,person)
    mail(from: from, 
         to: person.email,
         subject: subject,
         body: body)
  end  
end
