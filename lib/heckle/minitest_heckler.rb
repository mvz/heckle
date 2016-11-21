require 'minitest'
require_relative 'heckler'

module Heckle
  class MiniTestHeckler < Heckler
    def initialize(class_or_module, method, options)
      Dir.glob(options[:test_pattern]).each {|t| load File.expand_path(t) }

      super(class_or_module, method, options[:nodes])
    end

    def tests_pass?
      output = Heckler.debug ? $stdout: StringIO.new('')
      reporter = Minitest::CompositeReporter.new
      reporter << Minitest::SummaryReporter.new(output)
      reporter << Minitest::ProgressReporter.new(output)

      reporter.start
      Minitest::Runnable.runnables.each do |runnable|
        runnable.run(reporter, {})
      end
      reporter.report
      reporter.passed?
    end
  end
end
