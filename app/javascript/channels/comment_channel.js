import consumer from "./consumer"

$(document).on('turbolinks:load', () => {
  $('[data-channel-subscribe="challenge"]').each(function(index, element) {
      var $element = $(element),
          $chatList = $('#comment-list'),
          $form = $('#new-comment'),
          challenge_id = $element.data('challenge-id')

      consumer.subscriptions.create(
          {
              channel: "CommentChannel",
              challenge: challenge_id
          },
          {
              received: function(data) {
                  console.log(data.message)
                  $chatList.append(data.message)

                  $form[0].reset();
                  $chatList.animate({ scrollTop: $chatList.prop("scrollHeight") }, 1000)
              }
          }
      )
  });
});
