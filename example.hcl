listen {
  port = 4040
}

// consul {
//   enable = false
//   address = "localhost:8500"
//   datacenter = "dc1"
//   scheme = "http"
//   token = ""
//   service {
//     id = "nginx-exporter"
//     name = "nginx-exporter"
//     tags = ["foo", "bar"]
//   }
// }

namespace "service_a" {
  source_files = [
    "/var/log/nginx/logs/access.log"
    //   ,"/var/log/nginx/logs/error.log"
  ]
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" \"$http_x_forwarded_for\" rt=$request_time uct=\"$upstream_connect_time\" uht=\"$upstream_header_time\" urt=\"$upstream_response_time\""

  labels {
    service = "service-a"
  }

  // relabel "user" {
    // from = "remote_user"
    // whitelist = ["-", "user1", "user2"]
  // }

  relabel "request_uri" {
    from = "request"
    split = 2

    // match "^users/[0-9]+" {
    //   replacement = "/users/:id"
    // }
  }
}
