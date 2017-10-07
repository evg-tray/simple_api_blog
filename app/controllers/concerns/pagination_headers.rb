module PaginationHeaders
  extend ActiveSupport::Concern

  included do
    def self.set_pagination_headers(name, options = {})
      after_action(options) do
        results = instance_variable_get("@#{name}")
        headers['X-Total-Pages'] = results.total_pages
        headers['X-Total-Count'] = results.total_count
      end
    end
  end
end
