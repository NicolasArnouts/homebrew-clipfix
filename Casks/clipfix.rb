cask "clipfix" do
  version "0.1.2"

  on_arm do
    sha256 "b95650b7051ad0def4f08cb61484e16c7ea93e9446ae972af10e2bdcbd1d186c"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_aarch64.dmg",
        verified: "github.com/NicolasArnouts/ClipFix/"
  end
  on_intel do
    sha256 "5a5b487ae4a20ab314e237099e27740e52a77ef9d688727fcc3887a9b45780e2"

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
