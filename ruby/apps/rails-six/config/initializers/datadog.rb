require 'ddtrace'

Datadog.configure do |c|
  c.analytics_enabled = true
  c.runtime_metrics_enabled = true

  c.use :rails, service_name: 'rails-six'
end
