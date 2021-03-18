#!/bin/bash
set -eu
set -o pipefail

if [ "$(whoami)" != "root" ]; then
    echo "Must run script as root." >&2;
    exit 221;
fi

if grep docker /proc/1/cgroup -qa; then
    true;
else
    echo "Script meant to be run *only* on docker."
    exit 222;
fi

# Install Repos
for TOOL_NAME in $(cat tool.manifest); do
    git clone --depth=1  "${MERLIN_LIBRARY_BASE_URL}/${TOOL_NAME}.git" ${TOOL_NAME}
    mv ${TOOL_NAME}/* /usr/local/bin;
done

pushd /usr/local/bin;
rm *.md;
for shellExtensionFile in $(
        find . -type f | grep \.sh\$ | 
        cut -d / -f 2 | cut -d . -f 1
    );
    do
        mv $shellExtensionFile.sh ${shellExtensionFile};
done
