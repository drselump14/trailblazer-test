require "test_helper"

class AssertionsTest < Minitest::Spec
  class Test < Minitest::Spec
    def initialize(*)
      super
      @_assertions = []
    end

    def assert_equal(a, b)
      @_assertions << [a, b]
    end

    def call
      run
      @_assertions
    end

    include Trailblazer::Test::Assertions
  end


  it do
    test =
      Class.new(Test) do
        let(:model) { Struct.new(:title, :band).new("__Timebomb__", "__Rancid__") }

        #:exp-eq
        it do
          assert_exposes model, title: "Timebomb", band: "Rancid"
        end
        #:exp-eq end
      end.
      new(:test_0001_anonymous) # Note: this has to be that name, otherwise the test case won't be run!
      #spec_class.instance_methods.sort.grep(/test/).first

    assert_equal [["Timebomb", "__Timebomb__"], ["Rancid", "__Rancid__"]], test.()
  end
end
