ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address =>                                 "smtp.gmail.com",
	:port =>                                        587,
	:user_name =>                           "robertj.robinson@gmail.com",
	:password =>                                "aerial14s",
	:authentication =>                  "plain",
	:enable_starttls_auto =>        true
}
