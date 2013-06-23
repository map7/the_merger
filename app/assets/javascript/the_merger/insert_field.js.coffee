class window.TheMerger 

  insert_field: (body,field) ->
    start=body.caret().start;
    first_half=body.val().slice(0, start);
    last_half=body.val().slice(start, body.len);
    text = first_half + "[" + field + "]" + last_half
    body.val(text)
    false
