class ReportByAuthorJob < ApplicationJob
  queue_as :default

  def perform(start_date, end_date, email)
    data = User.find_by_sql(
        "SELECT
          users.id,
          users.nickname,
          users.email,
          COUNT(distinct posts.id) AS posts_count,
          COUNT(distinct comments.id) AS comments_count
        FROM
          users
          LEFT JOIN posts ON (posts.author_id = users.id)
            AND (posts.published_at BETWEEN '#{start_date}' AND '#{end_date}')
          LEFT JOIN comments ON (comments.author_id = users.id)
            AND (comments.published_at BETWEEN '#{start_date}' AND '#{end_date}')
        GROUP BY
          users.id
        HAVING COUNT(distinct posts.id) > 0 OR COUNT(distinct comments.id) > 0"
    ).sort { |i| i.posts_count + i.comments_count / 10 }.reverse
    ReportByAuthorMailer.send_report(start_date, end_date, email, data).deliver_now
  end
end
