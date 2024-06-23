#!/bin/sh
waitforservice init.svc.camera_service
timeout 5 gst-launch-1.0 droidcamsrc camera_device=0 mode=2 ! tee name=t t. ! queue ! video/x-raw, width=1920, height=1080 ! videoconvert ! videoflip video-direction=auto ! fakesink
timeout 5 gst-launch-1.0 droidcamsrc camera_device=0 mode=2 ! tee name=t t. ! queue ! video/x-raw, width=1920, height=1080 ! videoconvert ! videoflip video-direction=auto ! fakesink
