# homebrew-clipfix

Homebrew tap for **[ClipFix](https://clipfix.dev)** — turn a screen recording into context your coding agent can read (annotated keyframes + a written brief). macOS, open-source, powered by Gemini.

## Install

```sh
brew install --cask nicolasarnouts/clipfix/clipfix
```

That auto-taps this repo and installs the latest signed + notarized ClipFix. The app updates itself after that, so you only run this once.

Equivalent two-step form:

```sh
brew tap nicolasarnouts/clipfix
brew install --cask clipfix
```

## Maintaining the cask

After a new ClipFix release is published (e.g. tag `v0.1.0`):

```sh
scripts/update-cask.sh 0.1.0           # downloads the DMGs, fills version + sha256
brew audit --cask --strict Casks/clipfix.rb
git commit -am "clipfix 0.1.0" && git push
```

For later version bumps you can also use `brew bump-cask-pr --version <new> clipfix`.

## License

MIT — see [LICENSE](LICENSE). ClipFix itself is MIT too (it bundles GPL ffmpeg as a separate binary; see the ClipFix repo's `THIRD-PARTY-LICENSES.md`).
