class SshAgentFilter < Formula
  desc "filtering proxy for ssh-agent meant to be forwarded to untrusted servers"
  homepage "https://git.tiwe.de/ssh-agent-filter.git"
  license "GNU GPLv3"

  version "0.5.2"
  url "https://git.tiwe.de/ssh-agent-filter.git/snapshot/ssh-agent-filter-#{version}.tar.gz"
  sha256 "e37e5a09753518ca3e01477be7f6069935055a8cd96bfdeac3bb8c959881cdb9"

  depends_on "boost" => :build
  depends_on "nettle" => :build
  depends_on "help2man" => :build
  depends_on "pandoc" => :build
  depends_on "dialog"
  depends_on "zenity" => :optional

  def install
    # patch
    # No locale can avoid the error: "help2man: no locale support (Locale::gettext required)"
    inreplace "Makefile" do |s|
      s.gsub! "-L C.UTF-8 ", ""
    end

    # build
    system "make"

    # install
    ["ssh-agent-filter", "ssh-askpass-noinput", "afssh"].each do |p|
      bin.install p
      man1.install "#{p}.1"
    end
  end
end
