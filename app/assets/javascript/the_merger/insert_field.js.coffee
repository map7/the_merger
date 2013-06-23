class window.TheMerger

  insert_field: (body,field) ->
    start=body.caret().start;                          # Get the start of the caret
    first_half=body.val().slice(0, start);             # Get all text up to caret
    last_half=body.val().slice(start, body.len);       # Get all text from caret to end
    text = first_half + "[" + field + "]" + last_half  # Glue it all together with field
    body.val(text)                                     # Put the result back into the text_area
    false
