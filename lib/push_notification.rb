module PushNotification

  def self.send(udid, notification)
    # if Rails.env.development?
    #   puts "*" * 80
    #   puts "Push Notification: #{notification.body}"
    #   puts "*" * 80
    #   true
    # else
    #   fcm = FCM.new(Rails.application.secrets[:firebase][:server_key])
    #   options = {
    #       content_available: true,
    #       notification: {
    #           title: notification.body,
    #           body: notification.body,
    #           sound: "default",
    #           click_action: "action_receive_alert",
    #           badge: notification.user.unread_messages_count
    #       }
    #   }
    #   response = fcm.send_with_notification_key(udid, options)
    #   notification.update(sent: true) if response[:status_code] == 200
    # end
  end
end