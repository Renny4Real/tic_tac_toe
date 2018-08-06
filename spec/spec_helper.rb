# frozen_string_literal: true

require 'view_board'
require 'place_mark'
require 'check_board'
require 'player_gateway'
require 'AI'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered

  #
  #
  #
  #   config.disable_monkey_patching!
  #
  #   config.warnings = true
  #
  #
  #   if config.files_to_run.one?
  #
  #     config.default_formatter = "doc"
  #   end
  #
  #
  #   config.profile_examples = 10
  #
  #
  #   config.order = :random
  #
  #   Kernel.srand config.seed
end
