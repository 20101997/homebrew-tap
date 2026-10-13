cask "ditty" do
  version "0.1.0"
  sha256 "66a1a357acd590a3e9a88137b8d8802e3e27812b003d95da1d65e6a2bf7c1873"

  url "https://github.com/20101997/Ditty/releases/download/v#{version}/Ditty.zip"
  name "Ditty"
  desc "Clipboard manager modelled on Ditto for Windows"
  homepage "https://github.com/20101997/Ditty"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Ditty.app"

  # Ditty is not notarized, so macOS would refuse to open it. Installing from this tap clears the
  # download quarantine flag so it opens normally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ditty.app"]
  end

  uninstall quit: "com.ahmedchemkhi.ditty"

  zap trash: [
    "~/Library/Application Support/Ditty",
    "~/Library/Preferences/com.ahmedchemkhi.ditty.plist",
  ]

  caveats <<~EOS
    Ditty is not notarized by Apple. This cask removes the quarantine flag so it opens without a warning.

    To let Ditty paste into other apps, turn it on under
    System Settings > Privacy & Security > Accessibility. macOS asks for this again after each update.
  EOS
end
