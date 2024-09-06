#!/usr/bin/env bash
set -e

# Central installation directory
INSTALL_DIR="/usr/local/bin"

echo "Downloading veHub CLI..."
DATA=$(curl -s 'https://search.vector.com/at-de/_search/' \
         -H 'content-type: application/json' \
         -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) Chrome/115.0.5790.102' \
         --data-raw '{"from":0,"size":45,"query":{"function_score":{"score_mode":"first","boost_mode":"multiply","query":{"bool":{"should":[],"filter":[{"match":{"type":{"query":"downloads","boost":1,"operator":"AND"}}}],"must":[{"terms":{"downloadType":["freeware","demos","drivers","service"]}},{"terms":{"categoryProductDefaultLang":["69969"]}}]}}}},"explain":false,"sort":[{"sortdate":"desc"}]}')

LATEST_VERSION=$(echo $DATA | jq '[.hits.hits[] | select(._source.operatingSystem == "1")][0] | ._source | {title: .title, version: .version, url: .url}')
echo $LATEST_VERSION | jq '{title: .title, version: .version}'

URL=$(echo $LATEST_VERSION | jq -r '.url  | fromjson | .downloadAction' | head -n 1)

echo "Downloading from $URL..."

curl -L "https://vector.com$URL" \
         -H 'content-type: application/json' \
         -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) Chrome/115.0.5790.102' -o cli.zip

echo "Extracting veHub CLI..."
unzip cli.zip -d cli

# Make the binary executable
chmod +x cli/vehub

# Move the binary to /usr/local/bin to make it globally accessible
sudo mv cli/vehub "$INSTALL_DIR"

# Verify installation
if command -v vehub &> /dev/null
then
    echo "veHub CLI installed successfully at $(command -v vehub)"
else
    echo "veHub CLI installation failed!"
    exit 1
fi
