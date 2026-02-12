#!/usr/bin/env nu

let theme = {
    separator: "#222222"
    header: green_bold
}

$env.CARAPACE_BRIDGES = 'zsh,bash'

let carapace_completer = {|spans: list<string>|
    CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
}

$env.config = {
  show_banner: false
  completions: {
    external: {
      enable: true
      completer: $carapace_completer
    }
  }
  rm: {
    always_trash: true
  }
  table: {
    mode: compact
    index_mode: auto
  }
  history: {
    max_size: 10_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: false
  }
  cursor_shape: {
    emacs: underscore
  }
  color_config: $theme
  footer_mode: "auto"
  shell_integration: {
      osc2: true
      osc7: true
      osc8: true
      osc9_9: false
      osc133: true
      osc633: true
      reset_application_mode: true
  }
  use_kitty_protocol: true
  keybindings: [
    {
      name: delete_word
      modifier: control
      keycode: char_h # TODO: ctrl+backspace triggers `h`, this is a crossterm bug: https://github.com/crossterm-rs/crossterm/issues/685
      mode: emacs
      event: {
        until: [
          { edit: BackspaceWord }
        ]
      }
    }
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
  ]
}

$env.GPG_TTY = (tty)
$env.SSH_AUTH_SOCK = (gpgconf --list-dirs agent-ssh-socket)

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
