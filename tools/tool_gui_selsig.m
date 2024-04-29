## Select signal(s) from ultrasonic pulse transmission test, GUI
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_si] = tool_gui_selsig(p_ma, p_si)
##                     non-interactive mode
##                     return given signal index or given signal indeces (r_si = p_si)
##
## Usage 2: [r_si] = tool_gui_selsig(p_ma, [])
##          [r_si] = tool_gui_selsig(p_ma)
##                     interactive mode
##                     show signal selection dialogue, GUI
##
## p_ma ... maturity time array, Minutes, [<uint>]
## p_si ... signal index or signal indeces, optional, <uint> or [<uint>]
## r_si ... return: index or indeces of selected signal(s), <uint> or [<uint>]
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
function [r_si] = tool_gui_selsig(p_ma, p_si)
  
  ## check arguments
  if (nargin < 1)
    help tool_gui_selsig;
    error('Less arguments given!');
  endif
  if (nargin < 2)
    p_si = [];
  endif
  if isempty(p_ma)
    help tool_gui_selsig;
    error('Maturity array must not be empty!');
  endif
  
  ## setup selection options
  ## format of each list entry: <maturity> min (<signal_index>)
  selopts = {};
  for i = 1 : numel(p_ma)
    selopts = [selopts, sprintf('%d min (%d)', p_ma(i), i)];
  endfor
  
  ## select signal index by maturity
  if isempty(p_si)
    [sel, ok] = listdlg(...
      "Name", "Select signal", ...
      "PromptString", "Select one or more signals from ultrasonic pulse transmission test channel", ...
      "ListString", selopts, ...
      "SelectionMode", "multiple");
    if (ok == 1)
      r_si = sel;
    else
      error('Cancel button pressed! Exit.');
    endif
  else
    if (min(p_si) < 1) || (max(p_si) > numel(selopts))
      error('Choice is out of range [1,...,%d]! Exit.', numel(selopts));
    else
      r_si = p_si;
    endif
  endif
  
endfunction
