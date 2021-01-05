require 'datadog/demo_env'
require_relative 'datadog'
require_relative 'acme'

use Datadog::Contrib::Rack::TraceMiddleware if Datadog::DemoEnv.feature?('tracing')
run Acme::Application.new
