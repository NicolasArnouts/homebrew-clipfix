cask "clipfix" do
  version "0.1.0"

  on_arm do
    sha256 "REPLACE_WITH_AARCH64_DMG_SHA256"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_aarch64.dmg",
        verified: "github.com/NicolasArnouts/ClipFix/"
  end
  on_intel do
    sha256 "REPLACE_WITH_X64_DMG_SHA256"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_x64.dmg",
        verified: "github.com/NicolasArnouts/ClipFix/"
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
    "~/Library/LaunchAgents/com.clipfix.desktop.plist",
    "~/Library/Preferences/com.clipfix.desktop.plist",
    "~/Library/Saved Application State/com.clipfix.desktop.savedState",
  ]
  # NOTE: ClipFix keeps your captures in ~/.clipfix — intentionally NOT zapped, so
  # `brew uninstall --zap` never deletes your context packs. Remove it by hand if you want.
end
