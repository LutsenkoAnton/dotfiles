; ── Annotation delimiters ─────────────────────────────────────────
["/*@" "*/" "//@" "/@" "@/"] @comment
(comment) @comment

; ── Base layer for ghost code ───────────────────────────────────
; The C highlights injected on top override this wherever they set a color;
; everything they leave uncolored (e.g. @variable in many colorschemes)
; falls back to @ghost instead of the gray of the enclosing C comment.
(ghost_text) @ghost

; ── Fallback for plain identifiers ───────────────────────────────
; Must come first: later, more specific patterns override it. Without it,
; variables inherit the gray of the surrounding C comment.
(identifier) @variable

; ── Keywords ──────────────────────────────────────────────────────
[
  "requires" "ensures" "assumes" "assigns" "allocates" "frees"
  "decreases" "terminates" "exits"
  "behavior" "behaviors" "complete" "disjoint"
  "loop" "invariant" "variant"
  "assert" "check" "admit" "for"
  "reads" "ghost"
] @keyword

[
  "logic" "predicate" "inductive" "case" "lemma" "axiom" "axiomatic"
] @keyword.function

["type" "struct" "union" "enum"] @keyword.type

["\\forall" "\\exists" "\\let" "\\from"] @keyword.operator

; ── Types ─────────────────────────────────────────────────────────
(primitive_type) @type.builtin
(type (identifier) @type)
(type_declaration name: (identifier) @type.definition)

; ── Built-ins (\result, \old, \valid, ...) ────────────────────────
(builtin) @function.builtin
((builtin) @constant.builtin
  (#any-of? @constant.builtin "\\true" "\\false" "\\nothing" "\\null" "\\empty"))
((builtin) @variable.builtin
  (#any-of? @variable.builtin "\\result" "\\exit_status"))

; ── Declarations and calls ────────────────────────────────────────
(logic_declaration name: (identifier) @function)
(predicate_declaration name: (identifier) @function)
(inductive_declaration name: (identifier) @function)
(lemma_declaration name: (identifier) @function)
(axiomatic name: (identifier) @module)
(inductive_case name: (identifier) @label)
(behavior name: (identifier) @label)
(completeness_clause (identifier) @label)
(for_behaviors (identifier) @label)

(call_expression function: (identifier) @function.call)
(label_parameters (identifier) @label)
(label_arguments (identifier) @label)

((call_expression
   function: (builtin) @_f
   arguments: (arguments (_) (identifier) @label .))
  (#eq? @_f "\\at"))

(parameter name: (identifier) @variable.parameter)
(binder name: (identifier) @variable.parameter)
(let_expression name: (identifier) @variable)
(field_expression field: (identifier) @variable.member)

; ── Literals ──────────────────────────────────────────────────────
(number) @number
(string) @string
(char) @character

; ── Operators and punctuation ─────────────────────────────────────
[
  "==>" "<==>" "||" "&&" "^^" "!" "|" "^" "&" "~"
  "==" "!=" "<" "<=" ">" ">=" "<<" ">>"
  "+" "-" "*" "/" "%" "=" "->" "." ".." "?"
] @operator

["(" ")" "[" "]" "{" "}"] @punctuation.bracket
["," ";" ":"] @punctuation.delimiter
