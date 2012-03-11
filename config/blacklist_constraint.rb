class BlacklistConstraint
  def initialize
      @check_whitelist = APP_CONFIG['check_whitelist'].freeze
      @whitelist = APP_CONFIG['whitelist'].freeze
  end

  def matches?(request)
    if @check_whitelist
      @whitelist.nil? || !@whitelist.include?(request.remote_ip)
    end
  end
end
