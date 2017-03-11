salt = "3587e646ee5bc48e60fb7b29c7a43650961f33893846d8e06f83b528554518b352f563669db91e790ae781d2e9785baf2a2093acf2f6b7df434eebb72af6ce2f"

Paperclip.interpolates :random_string_skoot do |attachment, style|
	Hashids.new(salt, 10).encode(attachment.instance.id, attachment.instance.skoot.user_id)
end

Paperclip.interpolates :user_id_skoot do |attachment, style|
	Hashids.new(salt, 10).encode(attachment.instance.skoot.user_id)
end

Paperclip.interpolates :time do |attachment, style|
	attachment.instance.updated_at.to_s.gsub(/[^0-9]/, '')
end