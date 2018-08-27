# frozen_string_literal: true

require "hypernova/plugin/server_stacktrace/version"

module Hypernova
  module Plugin
    class ServerStacktrace
      def initialize(logger)
        @logger = logger
      end

      def after_response(current_response, _original_response)
        current_response.tap do |hash|
          hash
            .map { |name, result| [name, result.dig("error", "stack")] }
            .select { |_, stack_trace| stack_trace }
            .each { |name, stack_trace| log(name, stack_trace) }
        end
      end

      private

      def log(name, stack_trace)
        @logger.error <<~BODY
          The #{name} component failed to render with Hypernova. Error stack:
          #{stack_trace.join("\n    ")}
        BODY
      end
    end
  end
end
