## Create axes object and return axes object handle
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, p_sm, p_dm)
##                     non-interactive mode
##
## Usage 2: [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, p_sm, [])
##          [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, p_sm)
##                     non-interactive mode
##                     create 2D plot
##                     
## Usage 3: [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, "subplot", p_dm)
##                     non-interactive mode
##                     create subplot object for stacked plots
##                     p_cn = 1: create first axes object (top)
##                     p_cn = 2: create second axes object (bottom)
##                     
## Usage 3: [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, "axes", p_dm)
##          [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, [], p_dm)
##                     non-interactive mode
##                     create single axes object
##                     channel number p_cn is ignored
##
## p_fh ... figure object handle, <int>
## p_ss ... settings data structure, <struct_dsviewer_settings>
## p_cn ... channel number, optional, defualt = 1, <uint>
##            1: channel 1, compression wave, logitudinal
##            2: channel 2, shear wave, transversal
## p_sm ... subplot mode, optional, default = "axes", <str>
##            "subplot": create subplot object, p_cn is mandatory
##            "axes":    create axes object, p_cn is ignored
## p_dm ... dimension mode, optional, default = "2d", <str>
##            "2d": 2D plot mode
##            "3d": 3D plot mode
## r_ah  ... return: axes object handle, <int>
##
## see also: axes, subplot
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
function [r_ah] = tool_create_axes(p_fh, p_ss, p_cn, p_sm, p_dm)
  
  ## check arguments
  if (nargin < 2)
    help tool_create_axes;
    error('Less arguments given!');
  endif
  if (nargin < 3)
    p_cn = [];
  endif
  if (nargin < 4)
    p_sm = [];
  endif
  if (nargin < 5)
    p_dm = [];
  endif
  
  ## set default values
  if isempty(p_cn)
    p_cn = 1;
  endif
  if isempty(p_sm)
    p_sm = 'axes';
  endif
  if isempty(p_dm)
    p_dm = '2d';
  endif
  
  ## switch subplot mode
  switch (p_sm)
    case {'subplot', 'sub'}
      ## create subplot (stacked plots)
      r_ah = subplot(2, 1, p_cn);
    otherwise
      ## create single axes
      r_ah = axes();
  endswitch
  
  ## switch dimension mode
  switch (p_dm)
    case {'2d', '2D'}
      ## 2D plot
      set(r_ah, 'color', p_ss.p2d.bcol(p_cn, :));
      if (p_ss.p2d.gridon)
        set(r_ah, 'xgrid', 'on');
        set(r_ah, 'ygrid', 'on');
      endif
      set(r_ah, 'xlabel', p_ss.p2d.xlbl);
      set(r_ah, 'ylabel', p_ss.p2d.ylbl);
    case {'3d', '3D'}
      ## 3D plot
      set(r_ah, 'color', p_ss.p3d.bcol(p_cn, :));
      if (p_ss.p3d.gridon)
        set(r_ah, 'xgrid', 'on');
        set(r_ah, 'ygrid', 'on');
        set(r_ah, 'zgrid', 'on');
      endif
      set(r_ah, 'view', [-37.5, 30]);
      set(r_ah, 'xlabel', p_ss.p3d.xlbl);
      set(r_ah, 'ylabel', p_ss.p3d.ylbl);
      set(r_ah, 'zlabel', p_ss.p3d.zlbl);
    case {'tem', 'TEM', 'temp', 'TEMP', 'temperature', 'Temperature'}
      ## temperature plot (2D)
      set(r_ah, 'color', p_ss.tem.bcol);
      if (p_ss.tem.gridon)
        set(r_ah, 'xgrid', 'on');
        set(r_ah, 'ygrid', 'on');
      endif
      set(r_ah, 'xlabel', p_ss.tem.xlbl);
      set(r_ah, 'ylabel', p_ss.tem.ylbl);
  endswitch
  
endfunction
