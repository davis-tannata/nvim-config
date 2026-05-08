# nvim

Quite a messy nvim config. Borrows heavily from ThePrimeagen's keymaps.

## Layout

```
init.lua             -- entrypoint
lua/config/          -- lazy bootstrap, options, keymaps, lsp
lua/plugins/         -- one file per plugin
script/              -- tmux-sessionizer
```

## Highlights

- `lazy.nvim` — package manager
- `coc.nvim` — LSP + completion (TS, Dart/Flutter, etc.)
- `oil.nvim` — file explorer (`<leader>pv`)
- `fzf-lua` — fuzzy finding (`<leader>pf` / `pg` / `pb`)
- `arrow.nvim` — file marks (`H` / `L` to cycle)
- `toggleterm` + `lazygit` — floating lazygit on `<leader>lg`
- `conform` + `none-ls` — formatting / linting
- `kanagawa-wave` — active colorscheme (catppuccin / rose-pine / base2tone also installed)

Flutter is driven through `coc-flutter` (`<leader>fs` run, `fa` attach, `fr` hot restart, `fq` quit, `fd` devices, `fe` emulators, `fk` killall dart).

## Keymap notes

Leader is `<Space>`.

- `<C-f>` — launch tmux-sessionizer in a new tmux window
- `<leader>pf/pg/pb` — fzf files / live grep / buffers
- `<leader>pgf/pgd/po` — coc fzf-preview git / dir / oldfiles
- `gd` / `gr` / `gi` / `go` — coc definition / references / impl / type
- `K` — coc hover; `<F4>` — coc code action
- `<leader>u` — UndotreeToggle; `<leader>gs` — fugitive
- `<leader>w` — auto-indent whole file then save

The rest lives in `lua/config/keymaps.lua`.

## Dependencies

- `fzf`
- `tmux`
- `bat` (used as the fzf preview command in `init.lua`)
- ThePrimeagen's `tmux-sessionizer` (a copy lives in `script/`; edit the search paths inside it for your machine)
- `lazygit`
- A Node toolchain for `coc.nvim` extensions

## Install

```sh
git clone <this-repo> ~/.config/nvim
nvim   # lazy.nvim will bootstrap and install plugins on first launch
```
