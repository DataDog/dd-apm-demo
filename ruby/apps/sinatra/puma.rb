require 'ddtrace'
require 'pry'

Datadog.configure do |c|
  c.profiling.enabled = true

  # # Reconfigure transport to write pprof to file
  # c.profiling.exporter.transport = Datadog::Profiling::Transport::IO.default(
  #                                   write: ->(out, data) do
  #                                     result = nil
  #                                     filename = "test-#{Process.pid}.pprof"
  #                                     puts "Writing file #{filename}..."
  #                                     File.open(filename, "w") { |f| result = f.write(data) }
  #                                     puts "File #{filename} written!"
  #                                     result
  #                                   end
  #                                 )
end

Datadog.profiler.start

workers 1
threads 2, Integer(ENV['PUMA_THREADS'] || 24)

preload_app!

bind 'tcp://0.0.0.0:80'
environment ENV['SINATRA_ENV'] || 'development'

on_worker_boot do
  # Restart datadog profiler
  Datadog.profiler.start

  Thread.new do
    loop do
      puts "Profiler status (PID #{Process.pid}):"
      puts "Scheduler:        running?: #{Datadog.profiler.scheduler.running?}"
      puts "Stack collector:  running?: #{Datadog.profiler.collectors.first.running?}"
      buffers = Datadog.profiler.scheduler.recorder.instance_variable_get(:@buffers)
      puts "Recorder:         events: #{buffers.values.sum(&:length)}"

      sleep(10)
    end
  end
end
