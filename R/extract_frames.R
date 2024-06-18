#' Extract frames
#'
#' This function takes a path to a folder containing video clips and returns a folder with the frames.
#'
#' @param path Path to the folder containing video clips
#' @param fps Default: 1
#' @return Directory "images" with the frames from the specified folder.
#'
#' @export
#'
extract_frames <- function(path, fps = 1) {

  video_files <- list.files(path, pattern = "\\.mp4$", full.names = TRUE)

  output_dir <- file.path(path, "frames")
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

  video_files |>
    purrr::walk(\(video_file) {

      video_name <- tools::file_path_sans_ext(basename(video_file))

      temp_dir <- file.path(output_dir, video_name)
      if (!dir.exists(temp_dir)) dir.create(temp_dir, recursive = TRUE)

      print(glue::glue("extraindo frames do {video_name}"))

      av_video_images(video_file, destdir = temp_dir, format = "png", fps = fps)

      temp_files <- list.files(temp_dir, pattern = "\\.png$", full.names = TRUE)

      purrr::walk2(
        temp_files
        ,seq_along(temp_files)
        ,\(file, i) {
          new_name <- glue::glue("{video_name}_frame_{i}_{now() |> as_date()}.png")
          new_path <- file.path(temp_dir, new_name)
          file.rename(file, new_path)
        }
      )

    })

  dir_images <- file.path(path, "images")
  if (!dir.exists(dir_images)) dir.create(dir_images, recursive = TRUE)

  images <- list.files(output_dir, pattern = "\\.png$", recursive = TRUE, full.names = TRUE)
  file.copy(images, dir_images)

  unlink(output_dir, recursive = TRUE)
}
