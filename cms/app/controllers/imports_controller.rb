class ImportsController < ApplicationController
  respond_to :html

  def index
    @imports = Import.all
    respond_with(@imports)
  end

  def new
    @import = Import.new
    respond_with(@import)
  end

  def create
    @import = Import.new(import_params)
    @import.save

    ProcessDebtReportJob.perform_later @import

    redirect_to imports_url
  end

  private
    def import_params
      params.require(:import).permit(:debt_report)
    end
end
