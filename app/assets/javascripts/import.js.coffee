$(document).ready ->
  $('#import-submit').click (event) ->
    event.preventDefault()
    $btn = $(this)

    return if $(this).hasClass('disabled')

    disableBtn($btn)
    clearErrors()
    clearTable()

    $.ajax
      type: 'post'
      url: Routes.api_rest_v1_shelters_path()
      dataType: 'json'
      data:
        shelter:
          awo_id: $('#shelter_awo_id').val()
          import_count: $('#shelter_import_count').val()
      success: (response) ->
        enableBtn($btn)
        $table = $('.shelter-info')
        $('.name .val', $table).text response.name
        $('.awo-id .val', $table).text response.awo_id
        $('.address .val', $table).text "#{response.address}, #{response.city}, #{response.state} #{response.zip}"
        $('.phone .val', $table).text response.phone
        $('.fax .val', $table).text response.fax
        $('.animal-count .val', $table).text response.animal_count
        $table.show()
      error: (jqXHR, textStatus, errorThrown) ->
        enableBtn($btn)
        _.each JSON.parse(jqXHR.responseText).errors, (msg, attr) =>
          addError(attr, msg)


enableBtn = ($btn) ->
  $btn.text('Import').removeClass('disabled')

disableBtn = ($btn) ->
  $btn.text('Importing...').addClass('disabled')

clearTable = ->
  $table = $('.shelter-info')
  $('.name .val', $table).text ''
  $('.awo-id .val', $table).text ''
  $('.address .val', $table).text ''
  $('.phone .val', $table).text ''
  $('.fax .val', $table).text ''
  $('.animal-count .val', $table).text ''
  $table.hide()

addError = (key, msg) ->
  attribute = if key is 'awo_id'
    'Organization ID'
  else
    _.str.titleize(_.str.humanize(key))
  $('.errors').append $('<div/>', class: 'error').text("#{attribute} #{msg}.")

clearErrors = ->
  $('.errors').html('')
