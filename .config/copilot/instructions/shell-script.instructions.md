# Shell Script Generation Instructions

## Template

- For explicit shell-script requests, use `~/.config/nvim/skeletons/bash.sh`.
- Treat the template as canonical. Ask for user permission before deviating behavior or structure from the template.
- Do not apply the template to Copilot internal temporary commands.

## Defaults

- Target the current PC/OS by default.
- Add cross-platform or multi-architecture logic only when explicitly requested.
- Prefer const-correct shell style where possible, for example `local -r`.

## Output

- For user-facing shell scripts, print concise progress updates at key steps.
- Prefer box-drawing characters and ANSI colors for status output when stdout is a TTY; degrade cleanly without color.
