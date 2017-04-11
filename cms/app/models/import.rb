class Import < ActiveRecord::Base

  enum statuses: [:waiting, :processing, :processed]

  mount_uploader :debt_report, DebtReportUploader

end
