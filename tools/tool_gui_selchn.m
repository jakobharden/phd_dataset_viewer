## Select channel of ultrasonic pulse transmission test, GUI
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_cn] = tool_gui_selchn(p_cn)
##                     non-interactive mode
##                     return given channel number
##
## Usage 2: [r_cn] = tool_gui_selchn([])
##          [r_cn] = tool_gui_selchn()
##                     interactive mode
##                     show channel selection dialogue, GUI
##
## p_cn ... channel number, optional, <uint>
##            1: channel 1, compression wave, longitudinal
##            2: channel 2, shear wave, transversal
##            3: both channels, compression- and shear wave
## r_cn ... return: channel number, <uint>
##
## see also: dsviewer_2d.m, dsviewer_3d.m, dsviewer_mp4.m, dsviewer_settings.m, listdlg
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
function [r_cn] = tool_gui_selchn(p_cn)
  
  ## check arguments
  if (nargin < 1)
    p_cn = [];
  endif
  
  ## setup selection options
  selopts = {...
    "Compression wave (longitudinal)", ...
    "Shear wave (transversal)", ...
    "Compression and shear wave"};
  
  ## select channel
  if isempty(p_cn)
    [sel, ok] = listdlg(...
      "Name", "Select channel", ...
      "PromptString", "Select ultrasonic pulse transmission test channel(s)", ...
      "ListSize", [240, 300], ...
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
