require 'json'
require 'securerandom'

require 'sinatra'
require 'redis'
require 'sequel'

$REDIS = Redis.new(url: 'redis://redis:6379')
$DB = Sequel.sqlite

# Setup DB
$DB.create_table :requests do
  primary_key :id
  String :type
end

$REQUESTS_TABLE = $DB[:requests]
10000.times { $REQUESTS_TABLE.insert(type: rand <= 0.5 ? 'test' : 'none' ) }

class RequestIdMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    env['HTTP_X_REQUEST_ID'] = SecureRandom.uuid unless env.key?('HTTP_X_REQUEST_ID')
    @app.call(env)
  end
end

class Application < Sinatra::Base
  use RequestIdMiddleware

  get '/' do
    'Hello World!'
  end

  get '/test/case_a' do
    request_id = request.env['HTTP_X_REQUEST_ID']

    # Read from the database
    records = $REQUESTS_TABLE.where(type: 'test')

    sleep(rand * 0.1)

    # Add request to cache
    $REDIS.set('last-request', request_id)

    # Return response
    body JSON.generate(job_id: request_id)
  end
end
