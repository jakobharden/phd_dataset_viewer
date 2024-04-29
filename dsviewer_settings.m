## Return plot and rendering settings data structure
##
## FUNCTION SYNOPSIS:
##
## Usage: [r_ds] = dsviewer_settings()
##
## r_ds ... return: plot property data structure, <struct_dsviewer_settings>
##
## see also: dsviewer_2d.m, dsviewer_3d.m, dsviewer_mp4.m, dsviewer_tem.m
##
## Copyright 2023 Jakob Harden (jakob.harden@tugraz.at, Graz University of Technology, Graz, Austria)
## License: MIT
## This file is part of the PhD thesis of Jakob Harden.
## 
## Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
## documentation files (the “Software”), to deal in the Software without restriction, including without 
## limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of 
## the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
## 
## THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
## THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
## TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##
function [r_ds] = dsviewer_settings()
  
  ## init data structure
  r_ds.obj = 'struct_dsviewer_settings';
  r_ds.ver = int16([1, 0]);
  r_ds.des = 'Plot and fendering settings data structure';
  
  ##############################################################################
  ## General settings
  ##############################################################################
  
  ## Channel names (compression- and shear wave channels)
  r_ds.chname = {};
  r_ds.chname{1} = 'C wave'; # name, channel 1, compression wave
  r_ds.chname{2} = 'S wave'; # name, channel 2, shear wave
  r_ds.chname{3} = 'C/S wave'; # name, both channels
  r_ds.chshort = {};
  r_ds.chshort{1} = 'C'; # shortcut, channel 1, compression wave
  r_ds.chshort{2} = 'S'; # shortcut, channel 2, shear wave
  r_ds.chshort{3} = 'C/S'; # shortcut, both channels
  
  ## figure window size
  r_ds.fwwid = 1024; # width
  r_ds.fwhgt = 768; # height
  
  ## paper size and unit
  r_ds.pwid = 15; # width
  r_ds.phgt = 10; # height
  r_ds.punit = 'centimeters';
  
  ## length of electromagnetic response section (ERS), number of samples
  ## see also DOI: 10.3217/eh2ek-56e78, URL: https://repository.tugraz.at/records/eh2ek-56e78
  r_ds.erslen = [];
  r_ds.erslen(1) = 90; # channel 1, compression wave
  r_ds.erslen(2) = 90; # channel 2, shear wave
  r_ds.erslen(3) = max(r_ds.erslen); # channel 1 and 2, C/S wave
  
  ## length of pre-trigger section (PTS), number of samples
  ## this settings need to be updated after reading the dataset
  r_ds.ptslen = [];
  r_ds.ptslen(1) = 0; # channel 1, compression wave, ds.tst.s06.d11.v
  r_ds.ptslen(2) = 0; # channel 2, shear wave, ds.tst.s07.d11.v
  r_ds.ptslen(3) = 0; # channel 1 and 2, compression wave/shear wave
  
  ## step size for 3D plots, plot nth samples and signals
  ## this settings are used only if the amount of data is high (plot entire signal or mechanic response section)
  r_ds.stepsmp = 10; # plot nth sample of signal
  r_ds.stepsig = 2; # plot nth signal of series
  
  ##############################################################################
  ## 2D plot settings
  ##############################################################################
  
  ## axis labels
  r_ds.p2d.xlbl = 'Time [\musec]'; # x axis label
  r_ds.p2d.ylbl = 'Magnitude [V]'; # y axis label
  
  ## line width
  r_ds.p2d.lwid = [];
  r_ds.p2d.lwid(1) = 0.5; # channel 1, compression wave
  r_ds.p2d.lwid(2) = 0.5; # channel 2, shear wave
  
  ## line color
  r_ds.p2d.lcol = [];
  r_ds.p2d.lcol(1, :) = [1, 0, 0]; # channel 1, compression wave
  r_ds.p2d.lcol(2, :) = [0, 0, 1]; # channel 2, shear wave
  
  ## background color
  r_ds.p2d.bcol = [];
  r_ds.p2d.bcol(1, :) = [1, 1, 1]; # channel 1, compression wave
  r_ds.p2d.bcol(2, :) = [1, 1, 1]; # channel 2, shear wave
  
  ## show grid
  r_ds.p2d.gridon = true;
  
  ## maximum number of signal in one plot
  r_ds.p2d.plotmaxsig = 10;
  
  ##############################################################################
  ## 3D plot settings
  ##############################################################################
  
  ## axis labels, C/S wave
  r_ds.p3d.xlbl = 'Maturity [min]'; # x axis label
  r_ds.p3d.ylbl = 'Time [\musec]'; # y axis label
  r_ds.p3d.zlbl = 'Magnitude [V]'; # z axis label
  
  ## surface color maps
  r_ds.p3d.colmap = {};
  r_ds.p3d.colmap{1} = 'autumn'; # channel 1, compression wave
  r_ds.p3d.colmap{2} = 'winter'; # channel 2, shear wave
  
  ## background color
  r_ds.p3d.bcol = [];
  r_ds.p3d.bcol(1, :) = [1, 1, 1]; # channel 1, compression wave
  r_ds.p3d.bcol(2, :) = [1, 1, 1]; # channel 2, shear wave
  
  ## show grid
  r_ds.p3d.gridon = true;
  
  ##############################################################################
  ## Specimen temperature plot settings
  ##############################################################################
  
  ## axis labels
  r_ds.tem.xlbl = 'Maturity [min]'; # x axis label
  r_ds.tem.ylbl = 'Temperature [°C]'; # y axis label
  
  ## line width
  r_ds.tem.lwid = [];
  r_ds.tem.lwid(1) = 0.5; # channel t1
  r_ds.tem.lwid(2) = 0.5; # channel t2
  r_ds.tem.lwid(3) = 0.5; # channel t3
  r_ds.tem.lwid(4) = 0.5; # channel t4
  
  ## line color
  r_ds.tem.lcol = [];
  r_ds.tem.lcol(1, :) = [1, 0, 0]; # channel t1 
  r_ds.tem.lcol(2, :) = [0, 1, 0]; # channel t2
  r_ds.tem.lcol(3, :) = [0, 0, 1]; # channel t3
  r_ds.tem.lcol(4, :) = [0, 0, 0]; # channel t4
  
  ## background color
  r_ds.tem.bcol = [];
  r_ds.tem.bcol = [1, 1, 1];
  
  ## show grid
  r_ds.tem.gridon = true;
  
  ##############################################################################
  ## MP4 video settings
  ##############################################################################
  
  ## output file suffix list for mode 1 to 4
  r_ds.mp4.ofsfx = {};
  r_ds.mp4.ofsfx{1} = 'cs_combined';
  r_ds.mp4.ofsfx{2} = 'cs_stacked';
  r_ds.mp4.ofsfx{3} = 'c';
  r_ds.mp4.ofsfx{4} = 's';
  
  ## temporary directory to save the frames while rendering the video file
  ## see also: notes #2 in dsviewer_mp4.m
  r_ds.mp4.tmpdir_rd = '/mnt/ramdisk'; # prefered directory, ramdisk (ramfs)
  r_ds.mp4.tmpdir_fb = fullfile('.', 'tmp'); # local fallback directory if r_ds.mp4.tmpdir_rd or r_ds.mp4.tmpdir does not exist
  r_ds.mp4.tmpdir = ''; # updated during execution
  
  ## graph rendering settings
  r_ds.mp4.fwidth = 800; # frame width in pixel
  r_ds.mp4.fheight = 600; # frame height in pixel
  r_ds.mp4.frate = 5; # framerate, frames per second
  
  ## Threshold values for automated upper sample index limit detection
  ## This enables a more meaningful representation of the signal for the automated creation of MP4 video files.
  ## The upper limit is used to cutting off the right side of the signal which mainly consists of noise.
  ##
  ## number of signals used to compute the running average of entire signals
  r_ds.mp4.ulim_nsig = 5;
  ##
  ## threshold factor, used to find the index where the signal meagnitudes exceed the threshold value
  ## the threshold value is calculated by the maximum of the mean of signals times the threshold factor
  r_ds.mp4.ulim_thf = 0.1;
  ##
  ## filter window size (number of samples)
  ## the window size is a setting for the boxcar/ractangle filter used to smoothen the upper limit array
  ## if this value is 0, no filtering is performed
  r_ds.mp4.ulim_fltwinsize = 5;
  ##
  ## extend upper limit by this amount (number of samples)
  ## if value is 0, do no extend the upper limit
  r_ds.mp4.ulim_extsize = 300;
  
  ## MP4 metadata
  ##
  ## define strings
  str_pubyear = datestr(now(), '%Y');
  str_pubdate = datestr(now(), "%Y-%m-%d");
  str_autname = 'Jakob Harden';
  str_autmail = 'jakob.harden@tugraz.at';
  str_autaffil = 'Graz University of Technology, Graz, Austria';
  str_copyright = sprintf('Copyright %s %s (%s)', str_pubyear, str_autname, str_autaffil);
  str_comment = sprintf('This file is part of the PhD thesis of %s (%s). License: CC-BY-4.0 (https://creativecommons.org/licenses/by/4.0/).', str_autname, str_autmail);
  str_show = sprintf('PhD thesis of %s (%s).', str_autname, str_autmail); # PhD thesis
  str_episode_id = '1'; # first part of the PhD thesis
  ##
  ## add metadata to settings data structure
  r_ds.mp4.meta_title = ''; # update with dataset code
  r_ds.mp4.meta_author = sprintf('%s (%s)', str_autname, str_autaffil);
  r_ds.mp4.meta_album_artist = sprintf('%s (%s)', str_autname, str_autmail);
  r_ds.mp4.meta_artist = sprintf('%s (%s)', str_autname, str_autmail);
  r_ds.mp4.meta_album = 'Ultrasonic pulse transmission tests - '; # update with test series name
  r_ds.mp4.meta_grouping = ''; # update with test series code
  r_ds.mp4.meta_composer = 'Dataset Viewer, doi: 10.3217/c1ccn-8m982, function file: dsviewer_mp4.m';
  r_ds.mp4.meta_date = str_pubdate;
  r_ds.mp4.meta_track = ''; # update with dataset id
  r_ds.mp4.meta_comment = str_comment;
  r_ds.mp4.meta_genre = 'Ultrasonic pulse transmission tests';
  r_ds.mp4.meta_copyright = str_copyright;
  r_ds.mp4.meta_description = 'Visualization of signal series of ultrasonic pulse transmission tests';
  r_ds.mp4.meta_synopsis = 'Video content';
  r_ds.mp4.meta_show = str_show;
  r_ds.mp4.meta_episode_id = str_episode_id;
  r_ds.mp4.meta_network = str_autaffil;
  r_ds.mp4.meta_lyrics = 'N/A';
  
endfunction
