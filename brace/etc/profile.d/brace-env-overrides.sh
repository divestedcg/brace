#!/bin/sh
#Copyright (c) 2020 Divested Computing Group
#License: GPLv3

#misc
export CRYFS_NO_UPDATE_CHECK=true;

# zero video RAM to prevent leakage
# see (CC BY-SA 4.0): https://www.adlerweb.info/blog/2012/06/20/nvidia-x-org-video-ram-information-leak
export R600_DEBUG=zerovram;
export AMD_DEBUG=zerovram; #,tmz
export RADV_DEBUG=zerovram;

# enable gstreamer va-api plugin on unsupported drivers
export GST_VAAPI_ALL_DRIVERS=1;

# set restrictive umask
if [ "$(/usr/bin/id -ru)" -ge 1000 ] && [ "$(/usr/bin/id -u)" -ge 1000 ] && [ "$(/usr/bin/id -gn)" = "$(/usr/bin/id -un)" ]; then
    umask 0077;
else
    umask 0022;
fi;
