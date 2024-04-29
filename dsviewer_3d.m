## Plot 3D view of signal data
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, p_ss, p_cn, p_sn)
##                                 non-interactive mode
##
## Usage 2: [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, p_ss, p_cn, [])
##          [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, p_ss, p_cn)
##                                 interactive mode
##                                 show signal section selection dialogue, GUI
##
## Usage 3: [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, p_ss, [], p_sn)
##                                 interactive mode
##                                 show channel selection dialogue, GUI
##
## Usage 4: [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, [], p_cn, p_sn)
##                                 non-interactive mode
##                                 load default plot/rendering settings (see also: dsviewer_settings.m)
##
## Usage 5: [r_fh, r_ah, r_ph] = dsviewer_3d([], p_ss, p_cn, p_sn)
##                                 interactive mode
##                                 show dataset file selection dialogue, GUI
##
## p_fp ... full qualified file path to dataset file, optional, <str>
## p_ss ... settings data structure, optional, <struct_dsviewer_settings>
## p_cn ... channel number, optional, <uint>
##            1: channel 1, compression wave, logitudinal
##            2: channel 2, shear wave, transversal
##            3: both channels, compression- and shear wave
## p_sn ... signal section number, optional, <uint>
##            1: all, entire signal
##            2: pre-trigger section, PTS (noise recorded before trigger-point)
##            3: electromagentic response section, ERS (disturbance caused by pulse excitation)
##            4: mechanic response section, MRS (incoming compression- or shear wave)
## r_fh ... return: figure object handle(s), <int> or [<int>]
## r_ah ... return: axes object handle(s), <dbl> or [<dbl>]
## r_ph ... return: plot object handle(s), <dbl> or [<dbl>]
##
## see also: dsviewer_settings.m, tool_gui_dsload.m, tool_gui_selchn.m, tool_gui_selsec.m, tool_get_ptslen.m, tool_get_maturity.m,
##           tool_get_timesig.m, tool_get_magnitude.m, tool_create_figure.m, tool_create_axes.m, tool_create_plot3d.m
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
function [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, p_ss, p_cn, p_sn)
  
  ## check arguments
  if (nargin < 1)
    p_fp = [];
  endif
  if (nargin < 2)
    p_ss = [];
  endif
  if (nargin < 3)
    p_cn = [];
  endif
  if (nargin < 4)
    p_sn = [];
  endif
  
  ## load plot properties
  if isempty(p_ss)
    p_ss = dsviewer_settings();
  endif
  
  ## load dataset
  ds = tool_gui_dsload(p_fp);
  
  ## select channel
  cn = tool_gui_selchn(p_cn);
  
  ## select signal section
  sn = tool_gui_selsec(p_sn);
  
  ## get dataset code
  [p_ss.temp.dscode, p_ss.temp.dscodeplt] = tool_get_dscode(ds);
  
  ## get length of pre-trigger section (PTS)
  p_ss.ptslen = tool_get_ptslen(ds);
  
  ## select sample index range according to selected signal section
  nsmp = size(ds.tst.s06.d13.v, 1); # recorded block size, total number of samples
  nsig = size(ds.tst.s06.d13.v, 2); # number of recorded signals in signal series
  stepsmp = 1;
  stepsig = 1;
  switch (sn)
    case 1
      ## view entire signal
      ix0 = 1;
      ix1 = nsmp;
      stepsmp = p_ss.stepsmp;
      stepsig = p_ss.stepsig;
    case 2
      ## view PTS
      ix0 = 1;
      ix1 = p_ss.ptslen(cn) - 1;
    case 3
      ## view ERS
      ix0 = p_ss.ptslen(cn);
      ix1 = ix0 + p_ss.erslen(cn) - 1;
    case 4
      ## view MRS
      ix0 = p_ss.ptslen(cn) + p_ss.erslen(cn) - 1;
      ix1 = nsmp;
      stepsmp = p_ss.stepsmp;
      stepsig = p_ss.stepsig;
    otherwise
      help dsviewer_3d;
      error('Signal section number %d not defined!', sn);
  endswitch
  
  ## select plot range, index arrays
  ix = ix0 : stepsmp : ix1; # sample index range
  iy = 1 : stepsig : nsig; # maturity/signal index range
  
  ## get maturity array
  x1 = tool_get_maturity(ds, cn, 'min', iy);
  if (max(x1) < 10)
    x1 = tool_get_maturity(ds, cn, 'sec', iy);
    p_ss.p3d.xlbl = 'Maturity [sec]';
  endif
  
  ## get sample time signature array
  y1 = tool_get_timesig(ds, cn, 'usec')(ix);
  
  ## define plot legend
  leg = 'Sound wave';
  
  ## create 3D plot, switch channel selection
  switch (cn)
    case {1, 2}
      ## get matrix
      z1 = tool_get_magnitude(ds, cn, 'volts', iy)(ix, :);
      ## create figure object
      r_fh = tool_create_figure(p_ss, '3D plot', 'show');
      ## create axes object
      r_ah = tool_create_axes(r_fh, p_ss, cn, 'axes', '3d');
      ## create 3D plot
      r_ph = tool_create_plot3d(r_ah, p_ss, cn, x1, y1, z1, leg);
    case 3
      ## channel 1
      cn = 1;
      ## get matrix
      z1 = tool_get_magnitude(ds, cn, 'volts', iy)(ix, :);
      ## create figure object
      fh1 = tool_create_figure(p_ss, '3D plot', 'show');
      ## create axes object
      ah1 = tool_create_axes(fh1, p_ss, cn, 'axes', '3d');
      ## create 3D plot
      ph1 = tool_create_plot3d(ah1, p_ss, cn, x1, y1, z1, leg);
      ## channel 2
      cn = 2;
      ## get matrix
      z1 = tool_get_magnitude(ds, cn, 'volts', iy)(ix, :);
      ## create figure object
      fh2 = tool_create_figure(p_ss, '3D plot', 'show');
      ## create axes object
      ah2 = tool_create_axes(fh2, p_ss, cn, 'axes', '3d');
      ## create 3D plot
      ph2 = tool_create_plot3d(ah2, p_ss, cn, x1, y1, z1, leg);
      r_fh = [fh1, fh2];
      r_ah = [ah1, ah2];
      r_ph = [ph1, ph2];
    otherwise
      help dsviewer_3d;
      error('Channel selection number %d not defined!', cn);
  endswitch
  
endfunction
