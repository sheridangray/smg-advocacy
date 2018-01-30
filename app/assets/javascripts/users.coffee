# Intercept form submission
$form.on 'submit', (e) ->
  # Prevent form submission and repeat clicks
  e.preventDefault()
  $submit.attr 'disabled', 'disabled'
  # Submit the form via ajax
  $.ajax(
    url: '/call'
    method: 'POST'
    data: $form.serialize()).done((data) ->
    alert data.message
    return
  ).fail(->
    alert 'There was a problem calling you - please try again later.'
    return
  ).always ->
    $submit.removeAttr 'disabled'
    return
  return
