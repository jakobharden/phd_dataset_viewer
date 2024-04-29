## Update plot coordinates of existing 2D plot object
##
## FUNCTION SYNOPSIS:
##
## Usage 1: tool_update_plot2d(p_ph, p_xx, p_yy)
##            update x and y coordinates of plot object (graph)
##
## Usage 2: tool_update_plot2d(p_ph, p_xx, [])
##          tool_update_plot2d(p_ph, p_xx)
##            update x coordinates of plot object (graph) only
##
## Usage 3: tool_update_plot2d(p_ph, [], p_yy)
##            update y coordinates of plot object (graph) only
##
## p_ph ... plot object handle, <dbl>
## p_xx ... x coordinate array, sample time signatures, optional, default = [], [<dbl>]
## p_yy ... y coordinate array, sample magnitudes, optional, default = [], [<dbl>]
##
## see also: tool_create_plot.m, dsviewer_mp4.m
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
function tool_update_plot2d(p_ph, p_xx, p_yy)
  
  ## check arguments
  if (nargin < 3)
    p_yy = [];
  endif
  if (nargin < 2)
    p_xx = [];
  endif
  if (nargin < 1)
    help tool_update_plot2d;
    error('Less arguments given!');
  endif
  if isempty(p_ph)
    help tool_update_plot2d;
    error('Plot object handle missing!');
  endif
  
  ## update 2D plot coordinates
  if not(isempty(p_xx))
    set(p_ph, 'xdata', p_xx);
  endif
  if not(isempty(p_yy))
    set(p_ph, 'ydata', p_yy);
  endif
  
endfunction
