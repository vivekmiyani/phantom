# frozen_string_literal: true

module Phantom::Test
  NULL = "/dev/null"

  @processes = {}

  def self.processes
    @processes
  end

  Minitest.after_run do
    processes.each_value do |process|
      Process.kill "-TERM", process[:pid]
    rescue # rubocop:disable Style/RescueStandardError
      # do nothing
    end
  end

  def self.start(tag, command, dir:, url:, env: {})
    puts "* Starting #{tag}"
    pid = Process.spawn(env, command, chdir: dir, err: NULL, in: NULL, out: NULL, pgroup: true)

    processes[tag] = {
      command: command,
      dir: dir,
      url: url,
      env: env,
      pid: pid,
      loaded: false
    }
  end

  def self.wait_for(tag)
    return if processes[tag][:loaded]

    Timeout.timeout(240) do
      Net::HTTP.get(URI(processes[tag][:url]))

      processes[tag][:loaded] = true

      puts "* Started #{tag}"
      return
    rescue Errno::ECONNREFUSED
      sleep 1
      retry
    end
  end
end
