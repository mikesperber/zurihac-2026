# Beginner Track at ZuriHac 2026

## Haskell Installation

We need an installation of [Haskell](https://www.haskell.org/) and an
IDE, such as [Visual Studio Code](https://code.visualstudio.com/).

There are two basic ways of installing Haskell, GHCup and Nix.

### GHCup

- install [GHCup](https://www.haskell.org/ghcup/install/)

- choose all "Default" options
- answer "Do you want to install haskell-language-server (HLS)?" with "Yes"

Then type these commands:

```
ghcup install ghc 9.10.3
ghcup set ghc 9.10.3
```

To test the installation:

- open VSCode via  `code .` in this folder
- install `haskell.haskell` extension
- open the file `haskell-code/Intro.hs` and delete the last `e` in `where`
- after some wait, there should be red squiggles (not just red letters)

### Via Nix Installation (Linux, macOS, possibly WSL2)

- install [Nix](https://nixos.org/download.html#nix-install-linux)
  (Multi-user is great, but more difficult to remove later.)
- [turn on flakes](https://nixos.wiki/wiki/Flakes): this usually means
  to add to `~/.config/nix/nix.conf` the following ,line:

  ```
  experimental-features = nix-command flakes
  ```

- `cd <path-to>/haslkell-intro`
- `nix develop .#withVSCode` -> you should see a "Welcome to ZuriHac" promot
- `code .`
- open the file `haskell-code/Intro.hs` and delete the last `e` in `where`
- after some wait, there should be red squiggles (not just red letters)

#### Remarks

- If you want use your own VSCode (at your own risk), invoke
  via `nix develop` (without `.#withVSCode` weg). You still
  need the `haskell.haskell` extension.

