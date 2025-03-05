#!/bin/bash

HELP="
Using:
    $ sh setup-space.sh APP-ID [DEVELOPER-NAME] [DEVELOPER-LINK]

Uses developer username as developer name if name is empty.

DEVELOPER-LINK can be <email>

You can write \"--help\" or \"-h\" to show this message.
"

if [ $# -eq 0 ]; then
    echo "Nothing to do. You can write \"--help\" or \"-h\" to show help message."
    exit 1
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "$HELP"
    exit 0
fi

APP_ID="$1"
RESOURCES_PATH="/$(echo $APP_ID | sed 's/\./\//g')/"
RESOURCES_PATH_ESCAPED="$(echo $RESOURCES_PATH | sed 's/\//\\\//g')"

IFS="." read -r -a elems <<< "$APP_ID"

APP_NAMESPACE="${elems[-1]}"
APP_NAME=$(echo "$APP_NAMESPACE" | sed 's/\([a-z]\)\([A-Z]\)/\1 \2/g')
APP_COMMAND="$(echo "$APP_NAMESPACE" | sed 's/\(.\)\([A-Z]\)/\1-\2/g' | tr '[:upper:]' '[:lower:]')"
APP_COMMAND_C_NAME="$(echo $APP_COMMAND | sed 's/-/_/g')"
DEVELOPER_ID="${elems[0]}.${elems[1]}.${elems[2]}"
DEVELOPER_USERNAME="${elems[-2]}"

if [ $# -ge 2 ]; then
    DEVELOPER_NAME="$2"
else
	DEVELOPER_NAME="$DEVELOPER_USERNAME"
fi

if [ $# -ge 3 ]; then
    DEVELOPER_DATA="$DEVELOPER_NAME $3"
else
	DEVELOPER_DATA="$DEVELOPER_NAME"
fi

find ./ -type f -exec sed -i "s/<<APP-ID>>/$APP_ID/g" {} +
find ./ -type f -exec sed -i "s/<<RESOURCES-PATH>>/$RESOURCES_PATH_ESCAPED/g" {} +
find ./ -type f -exec sed -i "s/<<APP-NAME>>/$APP_NAME/g" {} +
find ./ -type f -exec sed -i "s/<<APP-COMMAND>>/$APP_COMMAND/g" {} +
find ./ -type f -exec sed -i "s/<<APP-COMMAND-C-NAME>>/$APP_COMMAND_C_NAME/g" {} +
find ./ -type f -exec sed -i "s/<<DEVELOPER-USERNAME>>/$DEVELOPER_USERNAME/g" {} +
find ./ -type f -exec sed -i "s/<<DEVELOPER-ID>>/$DEVELOPER_ID/g" {} +
find ./ -type f -exec sed -i "s/<<DEVELOPER-NAME>>/$DEVELOPER_NAME/g" {} +
find ./ -type f -exec sed -i "s/<<DEVELOPER-DATA>>/$DEVELOPER_DATA/g" {} +
find ./ -type f -exec sed -i "s/<<APP-NAMESPACE>>/$APP_NAMESPACE/g" {} +

find . -depth -name '*<<APP-ID>>*' -exec bash -c 'mv "$1" "${1//<<APP-ID>>/$2}"' _ {} "$APP_ID" \;

rm ./setup-space.sh
rm ./test-template.sh
