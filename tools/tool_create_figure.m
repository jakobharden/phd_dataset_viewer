## Create figure object and return figure object handle
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_fh] = tool_create_figure(p_ss, p_ft, p_vm)
##                     non-interactive mode
##
## Usage 2: [r_fh] = tool_create_figure(p_ss, p_ft, [])
##          [r_fh] = tool_create_figure(p_ss, p_ft)
##                     non-interactive mode
##                     show figure window, GUI
##
## Usage 3: [r_fh] = tool_create_figure(p_ss, [], p_vm)
##                     non-interactive mode
##                     set figure title to "Dataset Viewer"
##
## Usage 4: [r_fh] = tool_create_figure([], p_ft, p_vm)
##                     non-interactive mode
##                     load default plot/rendering settings (dsviewer_settings.m)
##
## p_ss ... settings data structure, optional <struct>
## p_ft ... figure title, optional, default = "Dataset Viewer", <str>
## p_vm ... view mode, optional, default = "show", <str>
##            "show": visible, interactive mode
##            "hide": invisible, automation mode
## r_fh ... return: figure object handle, <int>
##
## see also: dsviewer_settings.m, figure
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
function [r_fh] = tool_create_figure(p_ss, p_ft, p_vm)
  
  ## check arguments
  if (nargin < 1)
    p_ss = [];
  endif
  if (nargin < 2)
    p_ft = [];
  endif
  if (nargin < 3)
    p_vm = [];
  endif
  
  ## set default values
  if isempty(p_ss)
    p_ss = dsviewer_settings();
  endif
  if isempty(p_ft)
    p_ft = 'Dataset Viewer';
  endif
  if isempty(p_vm)
    p_vm = 'show';
  endif
  
  ## create figure
  switch (p_vm)
    case {'hide', 'hidden', 'invisible'}
      ## hide figure window
      r_fh = figure(...
        'visible', 'off', ...
        'menubar', 'none', ...
        'position', [100, 100, p_ss.mp4.fwidth, p_ss.mp4.fheight], ...
        "paperunits", p_ss.punit, ...
        "paperposition", [0, 0, p_ss.pwid, p_ss.phgt]);
    otherwise
      ## show figure window
      r_fh = figure(...
        "name", p_ft, ...
        "position", [200, 200, p_ss.fwwid, p_ss.fwhgt], ...
        "paperunits", p_ss.punit, ...
        "paperposition", [0, 0, p_ss.pwid, p_ss.phgt]);
  endswitch
  
endfunction
