$(document).ready ->
  $('#import-submit').click (event) ->
    event.preventDefault()
    $.ajax
      type: 'post'
      url: Routes.api_rest_v1_shelters_path()
      dataType: 'json'
      data:
        shelter:
          awo_id: $('#shelter_awo_id').val()
          count: $('#shelter_import_count').val()
      success: (response) ->
        console.log response
      error: (jqXHR, textStatus, errorThrown) ->
        console.log jqXHR
        console.log textStatus
        console.log errorThrown
