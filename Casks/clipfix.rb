cask "clipfix" do
  version "0.2.0"

  on_arm do
    sha256 "a7b9dd76470788530d28843075c43feccd819c255e093a4f17b3fbee5e344484"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_aarch64.dmg"
  end
  on_intel do
    sha256 "4f998a7c2449201711d1da1e443cb7cbb09db5b549d45ab8a8a78e99a6bfd5ba"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_x64.dmg"
  end

  name "ClipFix"
  desc "Turn a screen recording into context for your coding agent"
  homepage "https://clipfix.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # ClipFix ships its own minisign-verified updater (tauri-plugin-updater), so it
  # updates itself after install — Homebrew should not fight it.
  auto_updates true
  depends_on macos: :sequoia # macOS 15+ (matches the .dmg minimumSystemVersion)

  app "ClipFix.app"

  zap trash: [
    "~/Library/Application Support/com.clipfix.desktop",
    "~/Library/Caches/com.clipfix.desktop",
    "~/Library/HTTPStorages/com.clipfix.desktop",
    "~/Library/LaunchAgents/ClipFix.plist",
    "~/Library/Preferences/com.clipfix.desktop.plist",
    "~/Library/Saved Application State/com.clipfix.desktop.savedState",
  ]
  # NOTE: ClipFix keeps your captures in ~/.clipfix — intentionally NOT zapped, so
  # `brew uninstall --zap` never deletes your context packs. Remove it by hand if you want.
end
