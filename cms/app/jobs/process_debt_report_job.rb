# require 'smarter_csv'

class ProcessDebtReportJob < ActiveJob::Base
  queue_as :default

  def perform(import)
    # Do something later
    import.status = :processing
    import.save!

    current_debts = []
    SmarterCSV.process(import.debt_report.path, {}) do |chunk|
      chunk.each do |data_hash|
        debt = process_record(data_hash)
        current_debts << debt
      end
    end

    Debt.where('id NOT IN (?) AND paid = ?', current_debts.collect {|cd| cd.id }, false).update_all(paid: true)

    import.status = :processed
    import.save!
  end

  private
    def process_record(row)

      client = Client.find_or_create_by(name: row[:client_name]) do |c|
        c.contact_name = row[:client_contact_name]
        c.contact_phone = row[:client_contact_phone]
        c.address = row[:client_address]
        c.default_fine = row[:client_default_fine]
        c.default_interest = row[:client_default_interest]
      end

      condo = Condo.find_or_create_by(name: row[:condo_name], client: client) do |c|
        c.address = row[:condo_address]
      end

      tenant = Tenant.find_or_create_by(ssn: row[:tenant_ssn]) do |t|
        t.name = row[:tenant_name]
        t.billing_address = row[:tenant_billing_address]
        t.phone_number = row[:tenant_phone_number]
        t.email = row[:tenant_email]
      end

      unit = Unit.find_or_create_by(number: row[:unit_number], building_name: row[:unit_building], condo: condo) do |u|
        u.tenant = tenant
      end

      debt = Debt.find_or_create_by(due_date: row[:debt_due_date], debt_type: row[:debt_type], tenant: tenant, unit: unit) do |d|
        d.description = row[:debt_description]
        d.original_amount = row[:debt_original_amount]
      end

      debt

    end
end
