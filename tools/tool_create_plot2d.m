## Create 2D plot object and return plot object handle
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_ph] = tool_create_plot2d(p_ah, p_ss, p_cn, p_xx, p_yy, p_le)
##                     non-interactive mode
##
## Usage 2: [r_ph] = tool_create_plot2d(p_ah, p_ss, p_cn, p_xx, p_yy, [])
##          [r_ph] = tool_create_plot2d(p_ah, p_ss, p_cn, p_xx, p_yy)
##                     non-interactive mode
##                     use channel name as legend entry (see also: dsviewer_settings.m)
##
## Usage 3: [r_ph] = tool_create_plot2d(p_ah, p_ss, p_cn, [], p_yy, p_le)
##                     non-interactive mode
##                     use index of p_yy as x axis value
##
## Usage 4: [r_ph] = tool_create_plot2d(p_ah, p_ss, [], p_xx, p_yy, p_le)
##                     non-interactive mode
##                     use settings for channel 1 (p_cn = 1)
##
## Usage 5: [r_ph] = tool_create_plot2d(p_ah, [], p_cn, p_xx, p_yy, p_le)
##                     non-interactive mode
##                     load default plot/rendering settings (see also: dsviewer_settings.m)
##
## p_ah ... axes object handle, <int>
## p_ss ... settings data structure, optional, <struct_dsviewer_settings>
## p_cn ... channel number, optional, default = 1, <uint>
## p_xx ... x value array, sample time signatures, optional, default = [], [<dbl>]
## p_yy ... y value array, sample magnitudes, [<dbl>]
## p_le ... legend entry, optional, default = channel name, <str>
## r_ph ... return: plot (graph) object handle, <dbl>
##
## see also: dsviewer_settings.m, plot
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
function [r_ph] = tool_create_plot2d(p_ah, p_ss, p_cn, p_xx, p_yy, p_le)
  
  ## check arguments
  if (nargin < 5)
    help tool_create_plot2d;
    error('Less arguments given!');
  endif
  if (nargin < 6)
    p_le = [];
  endif
  
  ## set default values
  if isempty(p_ah)
    help tool_create_plot2d;
    error('Axes object handle missing!');
  endif
  if isempty(p_ss)
    p_ss = dsviewer_settings();
  endif
  if isempty(p_cn)
    p_cn = 1;
  endif
  if isempty(p_yy)
    help tool_create_plot2d;
    error('Y coordinate array is missing!');
  endif
  if isempty(p_le)
    p_le = p_ss.chname{p_cn};
  endif
  
  ## create 2D plot (graph)
  leg = sprintf(';%s;', p_le);
  if isempty(p_xx)
    r_ph = plot(p_ah, p_yy, 'linewidth', p_ss.p2d.lwid(p_cn), 'color', p_ss.p2d.lcol(p_cn, :), leg);
  else
    r_ph = plot(p_ah, p_xx, p_yy, 'linewidth', p_ss.p2d.lwid(p_cn), 'color', p_ss.p2d.lcol(p_cn, :), leg);
  endif
  
endfunction