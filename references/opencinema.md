# OpenCinema

An open-source hardware digital cinema camera (working title)


## Overview

There are a million video cameras, and an argument could be made that the idea of a video camera is obsolete, as a camera is embedded in every phone, laptop, etc.  But there are very few cameras that I would consider to be made for producing cinema, and none that I'm aware of which are built to be open-source.

I think there is a need for a quality open-source cinema camera.  In this document I'll describe what I feel are the essential properties of a quality cinema camera, as well as some implementation options.


## Description

Here's an unsorted list of things that I think are important:

*  Physical controls: ideally everything you need to touch/toggle/adjust exists as a discreet physical control (no burying things in menus, multipurpose buttons, etc.)
*  Film frame rates (18, 24 fps), faster-rates for real slow-mo, or variable rates via physical interface (think hand crank) would be great add-ons
*  Quality glass, optical zoom and image stabilization
*  No weird electronic shutter artifacts (jello-vision, etc.)
*  Minimal in-camera compression (ideally, none)
*  Raw image format
*  Optical viewfinder
*  Rugged
*  Heavy enough to be stable but not too heavy
*  Long battery life and/or field-replacable battery
*  Sound optional, but if present, doesn't compromise picture


## Notes

It looks like even the original (5mp) Raspberry Pi camera is capable of shooting 720p video at variable frame rates.  It would be interesting to couple this with something like a quality Super8 camera body and see what kind of results can be had.

After some experimentation a seemingly usable 3d model of a Super8 film cartridge has been designed (this would have been much easier if I had an example in-hand to work with).  What's surprising is that there seems to be a significant difference between the acceptable cartridge dimensions between the two cameras I've been testing with.  I'm not sure if this is to accomodate slight differences between manufacturers or something else, but regardless it makes reverse-designing the cartridge challenging.

A few other things became apparent once I had a "hardcopy" of the model.  The first is that there is zero chance of using a standard Raspberry Pi for this application (a Raspberry Pi Zero will be required).  Another challenge will be the power supply.  Unlike NextThingCo's Chip, the Raspberry Pi has no provisions for battery power, so a separate charge/power board will be required in addition to the battery itself.  

Finally, the Raspberry Pi camera module measures 23x25x9mm, which matches the smallest outside dimension of the cartidge case.  It might be possible to add a mm or two to the case but most likely the camera board will have to either cut into or through the outside wall of the cartridge (on the up-side, this answers the question of how the board will be secured...).  All of this makes for a pretty cramped space inside the (currently  70mm x 70mm x 23mm) cartridge.

I've ordered the necissary Raspberry Pi Zero W, camera board and charge controller/power supply (specifics can be found in the BOM).  I have a 1300mah li-ion battery that fits snugly in the cartridge that I'll use as well until I get a better idea of what the power requirements will be (and what the avaliable space will allow).

COmmand tha works OK: raspivid -w 640 -h 480 --framerate 18 -roi 0.1,0.4,0.3,0.3  --awb fluorescent -o test2.h264 -t 5000


## Prototype BOM

*  Raspberry Pi Zero W Camera Pack ($44.95) - https://www.adafruit.com/product/3414
*  Powerboost 500 Basic ($9.95) - https://www.adafruit.com/product/1903
*  1200mAh Lithium Ion Polymer battery ($9.95) - https://www.adafruit.com/product/258
*  3D printed cartridge - https://gitlab.com/jgullickson/open-digital-8


## References

*  https://www.raspberrypi.org/blog/new-camera-mode-released/
*  https://www.raspberrypi.org/documentation/hardware/camera/README.md
*  https://github.com/rellimmot/Sony-IMX219-Raspberry-Pi-V2-CMOS/blob/master/RASPBERRY%20PI%20CAMERA%20V2%20DATASHEET%20IMX219PQH5_7.0.0_Datasheet_XXX.PDF
*  http://www.oocities.org/sunsetstrip/studio/4474/super8mmcartspec.html
*  https://www.raspberrypi.org/documentation/hardware/camera/
*  https://i1.wp.com/blog.protoneer.co.nz/wp-content/uploads/2015/11/Raspberry-Pi-Zero-Dimensions-Footprint.jpg
*  https://www.adafruit.com/product/3414
*  http://super8wiki.com/images/b/bb/Cartridgenotchruler.jpg
*  https://www.raspberrypi.org/documentation/raspbian/applications/camera.md
*  https://github.com/ashtons/picam
*  https://www.raspberrypi.org/blog/picamera-pure-python-interface-for-camera-module/
