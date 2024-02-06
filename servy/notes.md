---
runme:
  id: 01HP01F56FQRXGF8PQ32Z50N2P
  version: v2.2
---

`|>` represent a pipeline

- get the length of an string
  `String.length(conv.resp_body)`

- content length with UTF-8 encoding for an HTTP response
  `#{byte_size(conv.resp_body)}`

print map:
`IO.inspect map_name`

inline function:
`def function_name(args), do: _action_`

- elixir tries to match from top to bottom
- defp is a private function ant cannot be called outside of the module