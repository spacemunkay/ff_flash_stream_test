# ff_flash_stream_test
Debugging Flash issues in Mozilla Firefox

# Instructions
 * Open RawStreamTest.html
 * Allow Flash permissions
 * Input desired .flv video file URL
 * Click 'Load Stream'

# Compiling .as script example
Install Adobe Flash Builder or Adobe Flex SDK and find the mxmlc binary.
```
/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0/bin/mxmlc -o outputfile.swf RawStreamTest.as
```

# Generating .flv video file with ffmpeg
Install ffmpeg commandline tool
```
ffmpeg -i videofile.mp4 -c:v libx264 -crf 19 videofile.flv
```

# Notes
* Make sure you have the latest Flash Player installed.
* In Chrome, even though Flash was installed, encountered a minor bug where it was necessary to click on 'Download Flash' in order to bring up 'Allow Flash' dialog.
