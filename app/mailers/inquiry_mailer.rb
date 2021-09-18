class InquiryMailer < ApplicationMailer
  default from: "example@example.com"   # 送信元アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(
      from: @inquiry.email,
      to: ENV['SEND_MAIL'],
      subject: 'お問い合わせを承りました'
    )
  end
end
