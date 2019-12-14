# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require_relative 'config.rb'
require './lib/message_link'
require './lib/eval_ruby'

bot = Discordrb::Commands::CommandBot.new(token: configatron.token, prefix:'!')

message_link = MessageLink.new(bot)
eval_ruby = EvalRuby.new

bot.message(&message_link.method(:on_message))
bot.command(:ruby, &eval_ruby.method(:eval_ruby))
bot.run
