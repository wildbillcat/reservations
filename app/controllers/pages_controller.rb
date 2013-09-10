class PagesController < HighVoltage::PagesController
  skip_before_filter :deny_banned_users
end
