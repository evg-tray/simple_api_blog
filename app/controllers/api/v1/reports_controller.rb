class Api::V1::ReportsController < ApplicationController

  def by_author
    if params[:start_date] && params[:end_date] && params[:email]
      ReportByAuthorJob.perform_later(params[:start_date], params[:end_date], params[:email])
      json_response({ message: Message.report_started })
    else
      json_response({ errors: [Message.invalid_params]}, :unprocessable_entity)
    end
  end
end
