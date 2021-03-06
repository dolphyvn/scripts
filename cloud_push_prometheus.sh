## Dynamic Points
# TODO.
# Template variables

export NOW="$(date +%s)"
opts=$1
data=$(curl -s -w "total:%{time_total} dns:%{time_namelookup} connect:%{time_connect} pretransfer:%{time_pretransfer} starttransfer:%{time_starttransfer} uploadspeed:%{speed_upload}" $1) 
upload_speed=$(echo $data|cut -d ' ' -f 6| cut -d ':' -f 2)

graphite_login="100384:eyJrIjoiMTU1MGM3OGQ3NjExNGY4MGZiYjYwNTU5ZjJlM2M2YmYyNjdhZWUwNCIsIm4iOiJkb2xwaHkiLCJpZCI6NDkyMTUwfQ=="
prom_login="100383:eyJrIjoiMTU1MGM3OGQ3NjExNGY4MGZiYjYwNTU5ZjJlM2M2YmYyNjdhZWUwNCIsIm4iOiJkb2xwaHkiLCJpZCI6NDkyMTUwfQ=="
prom_url="https://prometheus-blocks-prod-us-central1.grafana.net/api/prom/push"
graphite_url="https://graphite-us-central1.grafana.net/metrics"
# Curl command
curl -X POST $graphite_url \
-u $login
-H "Content-Type: application/json" \
-d @- << EOF
{
  "series": [
    {
      "metric": "upload.speed.mbps",
      "points": [
        [
          "${NOW}",
          "${upload_speed}"
        ]
      ]
    }
  ]
}
EOF
