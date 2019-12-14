# frozen_string_literal: true

class MessageLink
  def initialize(bot)
    @bot = bot
  end

  def on_message(event)
    return unless include_link?(event.message.content)

    links = get_links(event.message.content)

    links.each do |link|
      messageid = get_messageid(link)
      channelid = get_channelid(link)

      linked_message = load_message(channelid, messageid)
      linked_author = Discordrb::Webhooks::EmbedAuthor.new(
        icon_url: "https://cdn.discordapp.com/avatars/#{linked_message[:author][:id]}/#{linked_message[:author][:avatar]}.webp",
        name: linked_message[:author][:username]
      )

      event.send_embed do |embed|
        embed.author = linked_author
        embed.description = linked_message[:content]
      end
    end
  end

  def include_link?(content)
    content.match?(
      %r{https://discordapp.com/channels/[0-9]{18}/[0-9]{18}/[0-9]{18}}
    )
  end

  def get_links(content)
    content.scan(
      %r{https://discordapp.com/channels/[0-9]{18}/[0-9]{18}/[0-9]{18}}
    )
  end

  def get_channelid(link)
    link.split('/')[5]
  end

  def get_messageid(link)
    link.split('/')[6]
  end

  def load_message(channelid, messageid)
    rest_client_message = Discordrb::API::Channel.message(@bot.token, channelid, messageid)
    string_hash_message = rest_client_message.body.gsub('null', 'nil')
    hash_message = eval(string_hash_message)

    hash_message
  end
end
