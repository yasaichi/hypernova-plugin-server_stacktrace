# frozen_string_literal: true

require "json"
require "logger"
require "stringio"

RSpec.describe Hypernova::Plugin::ServerStacktrace do
  let(:plugin) { described_class.new(logger) }
  let(:logger) { spy(:logger) }

  describe "#after_response" do
    let(:described_method) { ->{ plugin.after_response(JSON.parse(fixture), double(:ignored)) } }
    let(:fixture) { File.read(File.expand_path("../../fixtures/response.json", __dir__)) }

    describe "return value" do
      subject { described_method.call }
      it { is_expected.to eq JSON.parse(fixture) }
    end

    describe "logger" do
      subject { logger }

      let(:expected_output) do
        <<~LOG
          The ComponentName.js component failed to render with Hypernova. Error stack:
          foo
              bar
        LOG
      end

      before do
        described_method.call
      end

      it { is_expected.to have_received(:error).once.with(expected_output) }
    end
  end
end
