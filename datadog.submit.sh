## Dynamic Points
# TODO.
# Template variables

DD_API_KEY=85dde615ff20de4a90912df878915823
export NOW="$(date +%s)"
opts=$1
data=$(curl -s -w "total:%{time_total} dns:%{time_namelookup} connect:%{time_connect} pretransfer:%{time_pretransfer} starttransfer:%{time_starttransfer} uploadspeed:%{speed_upload}" $1) 
upload.speed=$(echo $data|cut -d ' ' -f 6| cut -d ':' -f 2)



# Curl command
curl -X POST "https://api.datadoghq.com/api/v1/series" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-d @- << EOF
{
  "series": [
    {
      "metric": "datadog.dogstatsd.client.bytes_sent",
      "points": [
        [
          "${NOW}",
          "1234.5"
        ]
      ]
    }
  ]
}
EOF
