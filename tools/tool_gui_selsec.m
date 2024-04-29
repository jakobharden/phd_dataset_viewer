## Select signal section of ultrasonic signal, GUI
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_sn] = tool_gui_selsec(p_sn)
##                     non-interactive mode
##                     return the given signal section number (r_sn = p_sn)
##
## Usage 2: [r_sn] = tool_gui_selsec([])
##          [r_sn] = tool_gui_selsec()
##                     interactive mode
##                     show signal section selection dialog, GUI
##
## p_sn ... signal section number, optional, <uint>
##            1: all (entire signal)
##            2: pre-trigger section, PTS (noise before trigger point)
##            3: electromagentic response section, ERS (disturbance caused by pulse excitation)
##            4: mechanic response section, MRS (sound wave)
## r_sn ... return: signal section number, <uint>
##
## see also: dsviewer_3d.m, dsviewer_settings.m
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
function [r_sn] = tool_gui_selsec(p_sn)
  
  ## check arguments
  if (nargin < 1)
    p_sn = [];
  endif
  
  ## select channel
  if isempty(p_sn)
    selopts = {...
      "Entire signal", ...
      "Pre-trigger section (noise before trigger-point)", ...
      "Electromagnetic response section (disturbance)", ...
      "Mechanical response section (sound wave)"};
    [sel, ok] = listdlg(...
      "Name", 'Select signal section', ...
      "PromptString", "Select one of the signal sections", ...
      "ListSize", [300, 120], ...
      "ListString", selopts, ...
      "SelectionMode", "single");
    if (ok == 1)
      r_sn = sel;
    else
      error('Cancel button pressed! Exit.');
    endif
  else
    r_sn = p_sn;
  endif
  
endfunction
