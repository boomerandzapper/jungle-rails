class UserMailer < ApplicationMailer

  default from: 'noreply@jungle.com'

  def order_email(order, current_user)
    @user = current_user
    @order = order
    mail(to: @user.email, subject: 'Reciept for Jungle Order # ' + order.id.to_s)
  end

end
