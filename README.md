# videoframetools

**videoframetools** is an R package that provides tools to cut videos into clips and extract frames from these clips, simplifying the preparation of datasets for training ML/AI models.

## Features

> Video Clipping: cut videos into smaller clips based on a dataframe containing begin and end times.\
> Frame Extraction: extract frames from a folder of video clips for dataset preparation.

## Installation

To install the **videoframetools** package, use:

`devtools::install_github("jgoliv/videoframetools")`

You'll also need to install `ffmpeg`. To do so, run the following command in your terminal:

`sudo apt-get install ffmpeg`

## Usage

```{r}

video_path <- "path/to/your/video.mp4"
output_dir <- "path/to/your/directory"

dftrim <- tribble(
  ~begin, ~end,
  "00:00:00", "00:00:05",
  "00:00:06", "00:00:10",
  "00:00:11", "00:00:15",
  "00:00:16", "00:00:20",
  "00:00:21", "00:00:25"
)

trim_video(video_path, dftrim, output_dir)
extract_frames(output_dir)


```
