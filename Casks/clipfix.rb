cask "clipfix" do
  version "0.1.0"

  on_arm do
    sha256 "82879ba5b34c948a11ee6269fe6619963750a8df77306894a6ff8e0bf1e27079"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_aarch64.dmg",
        verified: "github.com/NicolasArnouts/ClipFix/"
  end
  on_intel do
    sha256 "3d0b305dd624e7d1b1abe7c874ae57fe5bf24485ae4a8ffb4cfe7db88309f9cf"

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
    "~/Library/LaunchAgents/ClipFix.plist",
    "~/Library/Preferences/com.clipfix.desktop.plist",
    "~/Library/Saved Application State/com.clipfix.desktop.savedState",
  ]
  # NOTE: ClipFix keeps your captures in ~/.clipfix — intentionally NOT zapped, so
  # `brew uninstall --zap` never deletes your context packs. Remove it by hand if you want.
end
