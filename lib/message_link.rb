# frozen_string_literal: true

class MessageLink
  def on_message(event)
    return unless include_link?(event.message.content)

    links = get_links(event.message.content)

    links.each do |link|
      messageid = get_messageid(link)
      linked_message = load_message(event.server.text_channels, messageid)
      linked_author = Discordrb::Webhooks::EmbedAuthor.new(
        icon_url: linked_message.author.avatar_url,
        name: linked_message.author.display_name
      )

      event.send_embed do |embed|
        embed.author = linked_author
        embed.description = linked_message.content
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

  def load_message(channels, messageid)
    channels.each do |channel|
      message = channel.load_message(messageid)
      return message unless message.nil?
    end
  end
end
