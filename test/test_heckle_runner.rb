require 'minitest/autorun'
require 'heckle/heckle_runner'

# Tests needed:
# * if no method, loads all local methods
# * should raise an exception if the class/module can't be found
# * should raise an exception if the method can't be found
# * Tests for option parsing.

class TestHeckleRunnerRun < Minitest::Test
  @@dummy_dir = File.expand_path('test/fixtures/minitest_project')
  dummy_lib = File.join(@@dummy_dir, 'lib')

  $LOAD_PATH << dummy_lib

  def setup
    super

    @old_pwd = Dir.pwd
    Dir.chdir @@dummy_dir

    Minitest::Runnable.reset
  end

  def teardown
    super
    Dir.chdir @old_pwd

    Minitest::Runnable.runnables.each do |test|
      Object.send :remove_const, test.to_s.to_sym
    end
  end

  def test_run_with_full_coverage
    result = nil
    out, _ = capture_io do
      result = Heckle::HeckleRunner.run %w[Doubler double]
    end

    assert result
    assert_match %r{No mutants survived.}, out
  end

  def test_run_with_partial_coverage
    result = true
    out, _ = capture_io do
     result = Heckle::HeckleRunner.run %w[Doubler double --tests test/test_doubler_with_a_number.rb]
    end

    refute result
    assert_match %r{The following mutations didn't cause test failures:}, out
    refute_match %{No mutants survived.}, out
  end
end
