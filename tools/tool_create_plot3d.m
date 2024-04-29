## Create 3D plot object (surface plot) and return plot object handle
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_ph] = tool_create_plot3d(p_ah, p_ss, p_cn, p_xx, p_yy, p_zz, p_le)
##                     non-interactive mode
##
## Usage 2: [r_ph] = tool_create_plot3d(p_ah, p_ss, p_cn, p_xx, p_yy, p_zz, [])
##          [r_ph] = tool_create_plot3d(p_ah, p_ss, p_cn, p_xx, p_yy, p_zz)
##                     non-interactive mode
##                     use channel name as legend entry (see also: dsviewer_settings.m)
##
## Usage 3: [r_ph] = tool_create_plot3d(p_ah, p_ss, p_cn, p_xx, [], p_zz, p_le)
##                     non-interactive mode
##                     use index of first dimension of p_zz as y coordinates
##
## Usage 4: [r_ph] = tool_create_plot3d(p_ah, p_ss, p_cn, [], p_yy, p_zz, p_le)
##                     non-interactive mode
##                     use index of second dimension of p_zz as x coordinates
##
## Usage 5: [r_ph] = tool_create_plot3d(p_ah, p_ss, [], p_xx, p_yy, p_zz, p_le)
##                     non-interactive mode
##                     use settings for channel 1 (p_cn = 1)
##
## Usage 6: [r_ph] = tool_create_plot3d(p_ah, [], p_cn, p_xx, p_yy, p_zz, p_le)
##                     non-interactive mode
##                     load default plot/rendering settings (see also: dsviewer_settings.m)
##
## p_ah ... axes object handle, <int>
## p_ss ... settings data structure, optional, <struct>
## p_cn ... channel number, optional, default = 1, <uint>
## p_xx ... x value array, sample time signatures, optional, default = [], [<dbl>]
## p_yy ... y value array, sample magnitudes, [<dbl>]
## p_le ... legend entry, optional, default = channel name, <str>
## r_ph ... return: plot (graph) object handle, <dbl>
##
## see also: surf
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
function [r_ph] = tool_create_plot3d(p_ah, p_ss, p_cn, p_xx, p_yy, p_zz, p_le)
  
  ## check arguments
  if (nargin < 1)
    help tool_create_plot3d;
    error('Less arguments given!');
  endif
  if (nargin < 2)
    p_ss = [];
  endif
  if (nargin < 3)
    p_cn = [];
  endif
  if (nargin < 4)
    p_xx = [];
  endif
  if (nargin < 5)
    p_yy = [];
  endif
  if (nargin < 6)
    p_zz = [];
  endif
  if (nargin < 7)
    p_le = [];
  endif
  if isempty(p_ah)
    help tool_create_plot3d;
    error('Axes object handle missing!');
  endif
  if isempty(p_zz)
    help tool_create_plot3d;
    error('Z coordinate matrix is missing!');
  endif
  
  ## set default values
  if isempty(p_ss)
    p_ss = dsviewer_settings();
  endif
  if isempty(p_cn)
    p_cn = 1;
  endif
  if isempty(p_xx)
    dimsz = size(p_zz, 1);
    p_xx = transpose(linspace(1, dimsz, dimsz));
  endif
  if isempty(p_yy)
    dimsz = size(p_zz, 2);
    p_yy = transpose(linspace(1, dimsz, dimsz));
  endif
  if isempty(p_le)
    p_le = p_ss.chname{p_cn};
  endif
  
  ## prepare data for surface plot
  [xx, yy] = meshgrid(p_xx, p_yy);
  
  ## create 3d plot, surface plot
  hold(p_ah, 'on');
  colormap(p_ah, p_ss.p3d.colmap{p_cn});
  light(p_ah, "Position", [0.5 -1 1], "Style", 'infinite');
  lighting(p_ah, 'gouraud');
  r_ph = surf(p_ah, xx, yy, p_zz, 'linestyle', 'none', 'facecolor', 'interp', 'ambientstrength', 0.7, 'displayname', p_le);
  title(p_ah, sprintf('%s - %s', p_ss.temp.dscodeplt, p_ss.chname{p_cn}));
  hold(p_ah, 'off');
  
endfunction
