; Ghost code is plain C. The pieces between `/@ ... @/` annotations are
; combined into one C document per annotation, so statements split by a
; nested annotation still parse as a whole.
((ghost_text) @injection.content
  (#set! injection.language "c")
  (#set! injection.combined))
