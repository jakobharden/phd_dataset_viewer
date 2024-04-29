## Select channel of specimen temperature test, GUI
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_cn] = tool_gui_seltem(p_cn)
##                     non-interactive mode
##                     return given channel number (r_cn = p_cn)
##
## Usage 2: [r_cn] = tool_gui_seltem([])
##          [r_cn] = tool_gui_seltem()
##                     interactive mode
##                     show channel selection dialogue, GUI
##
## p_cn ... temperature channel selection, optional, <uint>
##            1: channel T1, specimen, center
##            2: channel T2, specimen, next to sensor
##            3: channel T3, specimen, lateral
##            4: channel T4, outside, air
##            5: channel T1 to T3, specimen temperatures
##            6: channel T1 to T4, all temperatures
## r_cn ... return: channel number, <uint>
##
## see also: dsviewer_tem.m, listdlg
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
function [r_cn] = tool_gui_seltem(p_cn)
  
  ## check arguments
  if (nargin < 1)
    p_cn = [];
  endif
  
  ## setup selection options
  selopts = {...
      "T1 (center)", ...
      "T2 (sensor)", ...
      "T3 (lateral)", ...
      "T4 (air)", ...
      "T1, T2, T3 (specimen)", ...
      "T1, T2, T3, T4 (all)"};
  
  ## select channel
  if isempty(p_cn)
    [sel, ok] = listdlg(...
      "Name", "Select channel", ...
      "PromptString", "Select specimen temperature test channel", ...
      "ListSize", [180, 140], ...
      "ListString", selopts, ...
      "SelectionMode", "single");
    if (ok == 1)
      r_cn = sel;
    else
      error('Cancel button pressed! Exit.');
    endif
  else
    if (p_cn < 1) || (p_cn > numel(selopts))
      error('Choice is out of range [1,...,%d]! Exit.', numel(selopts));
    else
      r_cn = p_cn;
    endif
  endif
  
endfunction
