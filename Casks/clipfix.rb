cask "clipfix" do
  version "0.1.1"

  on_arm do
    sha256 "0f8cd37bee5ed651a429937b170774955f0028f6faeb86544c1b4b1e4ec323d0"

    url "https://github.com/NicolasArnouts/ClipFix/releases/download/v#{version}/ClipFix_#{version}_aarch64.dmg",
        verified: "github.com/NicolasArnouts/ClipFix/"
  end
  on_intel do
    sha256 "f7599dd75e6b164e198833a1186dccb190166dca1627afb0c237183913e751fd"

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
