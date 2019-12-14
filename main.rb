# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require_relative 'config.rb'
require './lib/message_link'

bot = Discordrb::Bot.new token: configatron.token

message_link = MessageLink.new(bot)

bot.message(&message_link.method(:on_message))

bot.run
