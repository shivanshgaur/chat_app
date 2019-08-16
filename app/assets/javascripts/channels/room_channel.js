$(function() {
  $('[data-channel-subscribe="room"]').each(function(index, element) {
    var $element = $(element),
        room_id = $element.data('room-id')
        messageTemplate = $('[data-role="message-template"]');

    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)

    App.cable.subscriptions.create(
      {
        channel: "RoomChannel",
        room: room_id
      },
      {
        received: function(data) {
          var content = messageTemplate.children().clone(true, true);
          content.find('[data-role="message-text"]').text(data.message);
          content.find('[data-role="message-date"]').text(data.created_at);
          currentUserId = $element.data('current-user-id');
          if (currentUserId === data.user_id) {
            content.find('[class="message-content"]').attr('class', "message-content-1");
          }
          else {
            var context = new AudioContext()
            var o = context.createOscillator()
            var  g = context.createGain()
            o.type = 'triangle'
            o.connect(g)
            g.connect(context.destination)
            o.start(0)

            g.gain.exponentialRampToValueAtTime(
              0.00001, context.currentTime + 1.04
            )
          }

          $element.append(content);
          $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
        }
      }
    );
  });
});
