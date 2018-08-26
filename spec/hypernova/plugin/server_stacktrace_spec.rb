# frozen_string_literal: true

require "json"
require "logger"
require "stringio"

RSpec.describe Hypernova::Plugin::ServerStacktrace do
  let(:plugin) { described_class.new(logger) }
  let(:logger) { spy(:logger) }

  describe "#after_response" do
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
        response_fixture = File.read(File.expand_path("../../fixtures/response.json", __dir__))
        current_response = JSON.parse(response_fixture)

        plugin.after_response(current_response, double(:original_response))
      end

      it { is_expected.to have_received(:error).with(expected_output) }
    end
  end
end
