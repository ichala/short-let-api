class ReservationMailer < ApplicationMailer
  def notify(user, message)
    @message = message
    mail(
      to: user.email,
      subject: "Update on your reservation!"
    )
  end
end
