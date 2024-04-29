## Get dataset code from dataset metadata
##
## FUNCTION SYNOPSIS:
##
## Usage: [r_dc, r_tc] = tool_get_dscode(p_ds)
##
## p_ds ... dataset data structure, <struct_dataset>
## r_dc ... return: dataset code, <str>
## r_tc ... return: dataset code for plot titles (escape underscores), <str>
##
## see also: dsviewer_2d.m, dsviewer_3d.m, dsviewer_mp4.m
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
function [r_dc, r_tc] = tool_get_dscode(p_ds)
  
  ## check arguments
  if (nargin < 1)
    help tool_get_dscode;
    error('Less arguments given!');
  endif
  
  ## return dataset code
  r_dc = p_ds.meta_set.a01.v;
  
  ## return dataset code for plot titles, escape underscores
  r_tc = strrep(r_dc, '_', '\_');
  
endfunction
