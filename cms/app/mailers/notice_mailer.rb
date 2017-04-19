class NoticeMailer < ApplicationMailer
  def notice_email(tenant, debts)
    @tenant = tenant
    @debts = debts
    mail(to: @tenant.email, subject: "Payment pending")
    @debts.each do |d|
      d.notified = true
      d.save!
    end
  end
end
