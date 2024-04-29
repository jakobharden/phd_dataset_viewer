## Select MP4 video output mode, GUI
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_om] = tool_gui_selmp4om(p_om)
##                     non-interactive mode
##                     return given MP4 output mode (r_om = p_om)
##
## Usage 2: [r_om] = tool_gui_selmp4om([])
##          [r_om] = tool_gui_selmp4om()
##                     interactive mode
##                     show MP4 output mode selection dialog, GUI
##
## p_om ... MP4 output mode, optional, <uint>
##            1: combine signals from compression- and shear wave measurement
##            2: stack signals from compression- and shear wave measurement
##            3: render compression wave signal only
##            4: render shear wave signal only
##            5: render compression wave signals to separate files (subsequent execution of output mode 3 and 4)
## r_om ... return: MP4 output mode, <uint>
##
## see also: dsviewer_mp4.m, listdlg
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
function [r_om] = tool_gui_selmp4om(p_om)
  
  ## check arguments
  if (nargin < 1)
    p_om = [];
  endif
  
  ## setup selection optiona
  selopts = {...
      "C & S wave (combined)", ...
      "C & S wave (stacked)", ...
      "C wave only", ...
      "S wave only", ...
      "C & S wave (separate files)"};
  
  ## select channel
  if isempty(p_om)
    [sel, ok] = listdlg(...
      "Name", "Select MP4 output mode", ...
      "PromptString", "Select one of the MP4 output modes", ...
      "ListSize", [180, 120], ...
      "ListString", selopts, ...
      "SelectionMode", "single");
    if (ok == 1)
      r_om = sel;
    else
      error('Cancel button pressed! Exit.');
    endif
  else
    r_om = p_om;
  endif
  
endfunction
