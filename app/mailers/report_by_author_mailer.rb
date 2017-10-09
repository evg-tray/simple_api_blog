class ReportByAuthorMailer < ApplicationMailer

  def send_report(start_date, end_date, email, data)
    @start_date = start_date
    @end_date = end_date
    @data = data
    mail(to: email, subject: "Report by author from #{@start_date} to #{@end_date}")
  end
end
