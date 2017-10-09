class Message
  def self.invalid_credentials
    'Invalid email / password'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.report_started
    'Report generation started'
  end

  def self.invalid_params
    'Invalid params.'
  end
end
