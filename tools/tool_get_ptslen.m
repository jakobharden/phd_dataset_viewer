## Get length of pre-trigger section (the noise recorded before the trigger-point)
##
## FUNCTION SYNOPSIS:
##
## Usage: [r_pl] = tool_get_ptslen(p_ds)
##                   non-interactive mode
##
## p_ds ... dataset data structure, <struct_dataset>
## r_pl ... return: length of pre-trigger section (noise), number of samples, [1 x 3], [<uint>]
##            Array elements by index:
##              1: PTS length of channel 1, compression wave
##              2: PTS length of channel 2, shear wave
##              3: PTS maximum PTS length of both channels, is used when channel 1 and 2 are combined in one graph
##
## see also: dsviewer_3d.m, dsviewer_mp4.m
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
function [r_pl] = tool_get_ptslen(p_ds)
  
  ## check arguments
  if (nargin < 1)
    help tool_get_ptslen;
    error('Less arguments given!');
  endif
  
  ## init return value
  r_pl = zeros(1, 3);
  
  ## channel 1, number of pre-trigger samples (noise)
  r_pl(1) = p_ds.tst.s06.d09.v;
  
  ## channel 2, number of pre-trigger samples (noise)
  r_pl(2) = p_ds.tst.s07.d09.v;
  
  ## max. of channel 1 and 2, used for combined plots
  r_pl(3) = max(r_pl(1 : 2));
  
endfunction
