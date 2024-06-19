#' Trim video
#'
#' This function takes a .mp4 video and a data frame with 2 columns named \code{begin} and \code{end} containing the start and end times
#' for each clip in the format HH:MM:SS and returns a folder with the trimmed videos.
#'
#' Note: To use this function, you need to have \code{ffmpeg} installed. To install it, run the command
#' \code{sudo apt-get install ffmpeg} on your terminal.
#'
#' @param video_path Path to the video
#' @param dftrim Data frame containing the periods for each clip
#' @param output_dir Directory where the clips will be saved
#' @return Directory with the clips from the specified video.
#'
#' @export
#'
trim_video <- function(video_path, dftrim, output_dir) {

  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

  video_name <- tools::file_path_sans_ext(basename(video_path))

  1:nrow(dftrim) |>
    purrr::walk(\(i) {
      begin <- to_seconds(dftrim$begin[i])
      end <- to_seconds(dftrim$end[i])

      duration <- end - begin

      output_file <- file.path(output_dir, paste0(video_name, "trim_", i, ".mp4"))

      ffmpeg_command <-
        sprintf(
          "ffmpeg -i %s -ss %s -t %s -c copy %s"
          ,shQuote(video_path)
          ,format(as.POSIXct(begin, origin = "1970-01-01", tz = "UTC"), "%H:%M:%S")
          ,format(as.POSIXct(duration, origin = "1970-01-01", tz = "UTC"), "%H:%M:%S")
          ,shQuote(output_file)
        )

      system(ffmpeg_command)
    })

  return(output_dir)
}
