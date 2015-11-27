require 'discordrb/events/generic'
require 'discordrb/await'

module Discordrb::Events
  # Event raised when an await is triggered
  class AwaitEvent
    attr_reader :await
    delegate :key, :type, :attributes, to: :await

    def initialize(await, bot)
      @await = await
      @bot = bot
    end
  end

  # Event handler for AwaitEvent
  class AwaitEventHandler < EventHandler
    def matches?(event)
      # Check for the proper event type
      return false unless event.is_a? TypingEvent

      [
        matches_all(@attributes[:key], event.key) { |a, e| a == e },
        matches_all(@attributes[:type], event.class) { |a, e| a == e }
      ].reduce(true, &:&)
    end
  end
end