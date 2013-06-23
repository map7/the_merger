class window.TheMerger

  # constructor: ->
  #   $('.insert_field').click ->
  #     alert $(".mail_merge_body").val()
  #     false
      
  #   #   the_merger.insert_field($(".mail_merge_body"), $("#field").val())
  #   #   false
  #   # $('.insert_field').click ->
  #   #   this.foobar()
  #   #   # this.insert_field(body,field)
  #   #   false

  #   foobar: ->
  #     alert 'foo'

  insert_field: (body,field) ->
    start=body.caret().start;
    first_half=body.val().slice(0, start);
    last_half=body.val().slice(start, body.len);
    text = first_half + "[" + field + "]" + last_half
    body.val(text)
    false
