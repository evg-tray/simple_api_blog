get_token = ->
  $.ajax({
    type: "POST"
    url: '/api/v1/auth/login'
    data: { email: $('#email').val(), password: $('#password').val() }
    dataType: 'json'
    success: (data) ->
      $('#token').val(data['auth_token'])
  })

upload_avatar = (event) ->
  event.preventDefault()
  form = $('#avatar-form')[0]
  data = new FormData(form)
  get_token()
  $.ajax({
    type: "POST"
    url: '/api/v1/upload-avatar'
    data: data
    enctype: 'multipart/form-data'
    processData: false
    contentType: false
    beforeSend: (xhr) ->
      xhr.setRequestHeader("Authorization", $('#token').val())
    success: (data) ->
      $('#uploaded_avatar').show()
      $('#uploaded_avatar').attr('src', data.avatar_url)
      $('#error').hide()
    error: (e) ->
      $("#error").text('Error')
      $("#error").show()
      $('#uploaded_avatar').hide()
  })

$(document).on('click', '#upload_avatar', upload_avatar)
