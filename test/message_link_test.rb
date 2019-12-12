# frozen_string_literal: true

require 'minitest/autorun'
require './lib/message_link'

class MessageLinkTest < MiniTest::Test
  def setup
    @message_link = MessageLink.new
  end

  def test_include_link?
    assert_equal false, @message_link.include_link?('')
    assert_equal true, @message_link.include_link?('https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060')
    assert_equal true, @message_link.include_link?('!https://discordapp.com/channels/653208789771747339/653208789771747345/654582770915475466OK!')
  end

  def test_get_links
    assert_equal [], @message_link.get_links('')
    assert_equal(
      ['https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060'],
      @message_link.get_links('https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060')
    )
    assert_equal(
      ['https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060',
       'https://discordapp.com/channels/653208789771747339/653208789771747345/654582770915475466'],
       @message_link.get_links('https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060
                https://discordapp.com/channels/653208789771747339/653208789771747345/6545827709154754666')
    )
  end

  def test_get_channelid
    assert_equal(
      '653208789771747345',
      @message_link.get_channelid('https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060')
    )
  end

  def test_get_messageid
    assert_equal(
      '654582749965058060',
      @message_link.get_messageid('https://discordapp.com/channels/653208789771747339/653208789771747345/654582749965058060')
    )
  end
end
