#!/usr/bin/env bash
set -ex
ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')
if [ "${ARCH}" == "arm64" ] ; then
    echo "Slack for arm64 currently not supported, skipping install"
    exit 0
fi
version=4.38.125
wget -q https://downloads.slack-edge.com/releases/linux/${version}/prod/x64/slack-desktop-${version}-${ARCH}.deb
apt-get update
# 👇 FIX for Kali: install missing dependency if needed
apt-get install -y libappindicator3-1 || true
# 👇 FIX: allow downgrades
apt-get install -y --allow-downgrades ./slack-desktop-${version}-${ARCH}.deb
rm slack-desktop-${version}-${ARCH}.deb
sed -i 's,/usr/bin/slack,/usr/bin/slack --no-sandbox,g' /usr/share/applications/slack.desktop
cp /usr/share/applications/slack.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/slack.desktop
chown 1000:1000 $HOME/Desktop/slack.desktop

# Test that slack --version works
echo "Testing Slack installation..."
if slack --version; then
    echo "✅ Slack installed successfully and version command works"
else
    echo "❌ Slack version command failed, but package should be installed"
fi