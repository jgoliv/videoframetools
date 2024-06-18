to_seconds <- function(t) {
  hms <- strptime(t, format = "%H:%M:%S")
  s <- as.numeric(hms$hour) * 3600 + as.numeric(hms$min) * 60 + as.numeric(hms$sec)
  return(s)
}

