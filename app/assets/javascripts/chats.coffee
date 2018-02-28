jQuery(document).on 'turbolinks:load', ->
  bajar_mensajes = -> mensajes.scrollTop(mensajes.prop("scrollHeight"))
  mensajes = $('#chat-body')

  if $('#current-user').size() > 0
    App.personal_chat = App.cable.subscriptions.create {
      channel: "NotifyChannel"
    },

    enviar_mensaje: (mensaje, chat_id) ->
      @perform 'enviar_mensaje', mensaje: mensaje, chat_id: chat_id

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
    if mensajes.size > 0 && mensajes.data('chat-id') is data['chat_id']
      mensajes.append data['mensaje']
      bajar_mensajes()
    else
      $.getScript('/chats') if $('#chats').size() > 0
      $('body').append(data['notification']) if data['notification']

    $(document).on 'click', '#notification .close', ->
      $(this).parents('#notification').fadeOut(1000)

    if mensajes.length > 0
      bajar_mensajes()
      $('#new_mensaje').submit (e) ->
        $this = $(this)
        textarea = $this.find('#mensaje_body')
        if $.trim(textarea.val()).length > 1
          App.personal_chat.enviar_mensaje textarea.val(), $this.find('#chat_id').val()
          textarea.val('')
        e.preventDefault()
        return false