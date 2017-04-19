class EmitNoticesController < SecuredController

  def index

    @days = params[:search_days].present? ? params[:search_days].to_i : 0
    @amount = params[:search_amount].present? ? params[:search_amount].to_f : 0

    @debts = Debt.where(notified: false).all.select { |d| d.updated_amount >= @amount and d.days_in_debt >= @days }
  end

  def emit
    debts = Debt.find(params[:debt_ids])

    debts_by_tenant = debts.group_by {|d| d.tenant }

    debts_by_tenant.each_pair do |tenant, debts|
      NoticeMailer.notice_email(tenant, debts).deliver_later
    end

    redirect_to root_url

  end

end
