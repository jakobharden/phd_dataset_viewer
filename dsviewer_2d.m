## Plot 2D view of signal data
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, p_ss, p_cn, p_si)
##                                 non-interactive mode
##
## Usage 2: [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, p_ss, p_cn, [])
##          [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, p_ss, p_cn)
##                                 non-interactive mode
##                                 plot all signals
##
## Usage 3: [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, p_ss, [], p_si)
##                                 interactive mode
##                                 show channel selection dialogue, GUI
##
## Usage 4: [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, [], p_cn, p_si)
##                                  non-interactive mode
##                                  load default plot/rendering settings (see also: dsviewer_settings.m)
##
## Usage 5: [r_fh, r_ah, r_ph] = dsviewer_2d([], p_ss, p_cn, p_si)
##                                 interactive mode
##                                 show dataset file selection dialogue, GUI
##
## p_fp ... full qualified file path to dataset file, optional, <str>
## p_ss ... settings data structure, optional, <struct_dsviewer_settings>
## p_cn ... channel number, optional, <uint>
##            1: channel 1, compression wave, logitudinal
##            2: channel 2, shear wave, transversal
##            3: both channels, stacked plot, compression- and shear wave
## p_si ... signal index, optional, <uint>
## r_fh ... return: figure object handle, <int>
## r_ah ... return: axes object handle(s), <dbl> or [<dbl>]
## r_ph ... return: plot object handle(s), <dbl> or [<dbl>]
##
## see also: dsviewer_settings.m, tool_gui_dsload.m, tool_gui_selchn.m, tool_get_maturity.m, tool_get_timesig.m, tool_get_magnitude.m,
##           tool_get_dscode.m, tool_create_figure.m, tool_create_axes.m, tool_create_plot2d.m
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
function [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, p_ss, p_cn, p_si)
  
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
    p_si = [];
  endif
  
  ## init return values
  r_fh = [];
  r_ah = [];
  r_ph = [];
  
  ## load settings data structure
  if isempty(p_ss)
    p_ss = dsviewer_settings();
  endif
  
  ## load dataset
  ds = tool_gui_dsload(p_fp);
  
  ## select channel
  cn = tool_gui_selchn(p_cn);
  
  ## select signal index by specimen maturity
  ma = tool_get_maturity(ds, cn, 'min');
  si = tool_gui_selsig(ma, p_si);
  
  ## limit number of signals in one plot
  if (numel(si) > p_ss.p2d.plotmaxsig)
    ## reduce to first n signals
    si = si(1 : p_ss.p2d.plotmaxsig);
    printf('The number of signals excceds the predefined limit! Only the first %d signals are shown..\n', p_ss.p2d.plotmaxsig);
  endif
  
  ## update plot properties
  [p_ss.temp.dscode, p_ss.temp.dscodeplt] = tool_get_dscode(ds);
  
  ## plot channel
  switch (cn)
    case {1, 2}
      ## single plot
      [r_fh, r_ah, r_ph] = hlp_plot_signal1(p_ss, ds, cn, si);
    case 3
      ## stacked plot
      [r_fh, r_ah, r_ph] = hlp_plot_signal2(p_ss, ds, si);
    otherwise
      help dsviewer_2d;
      error('Selected channel number %d is not defined!', cn);
  endswitch
  
endfunction

function [r_fh, r_ah, r_ph] = hlp_plot_signal1(p_ss, p_ds, p_cn, p_si)
  ## Create single 2D plot
  ##
  ## p_ss ... settings data structure, <struct_dsviewer_settings>
  ## p_ds ... dataset data structure, <struct>
  ## p_cn ... channel number, <uint>
  ## p_si ... signal index or signal index array, <uint> or [<uint>]
  ## r_fh ... return: figure object handle, <int>
  ## r_ah ... return: axes object handle, <dbl>
  ## r_ph ... return: plot object handles [1 x num_signals], [<dbl>]
  
  ## signal data
  mm = tool_get_maturity(p_ds, p_cn, 'min', p_si);
  tt = tool_get_timesig(p_ds, p_cn, 'usec');
  yy = tool_get_magnitude(p_ds, p_cn, 'volts', p_si);
  
  ## define colormap
  nsig = numel(p_si);
  colmap = viridis(nsig);
  
  ## create figure object
  r_fh = tool_create_figure(p_ss, '2D plot', 'show');

  ## create axes object
  r_ah = tool_create_axes(r_fh, p_ss, p_cn, 'axes', '2d');
  
  ## plot signal data
  r_ph = zeros(1, nsig);
  hold on;
  for i = 1 : nsig
    leg = sprintf('%s_{%d}: %d min', p_ss.chshort{p_cn}, p_si(i), mm(i));
    ## vary color
    if (nsig > 1)
      ## update settings, line color
      p_ss.p2d.lcol(p_cn, :) = colmap(i, :);
    endif
    r_ph(i) = tool_create_plot2d(r_ah, p_ss, p_cn, tt, yy(:, i), leg);
  endfor
  title(sprintf('%s - %s', p_ss.temp.dscodeplt, p_ss.chname{p_cn}));
  hold off;
  
endfunction

function [r_fh, r_ah, r_ph] = hlp_plot_signal2(p_ss, p_ds, p_si)
  ## Create stacked 2D plot
  ##
  ## p_ss ... settings data structure, <struct_dsviewer_settings>
  ## p_ds ... dataset data structure, <struct>
  ## p_si ... signal index or signal index array, <uint> or [<uint>]
  ## r_fh ... return: figure object handle, <int>
  ## r_ah ... return: axes object handles [1 x 2], [<dbl>]
  ## r_ph ... return: plot object handles [1 x 2*num_signals], [<dbl>]
  
  ## signal data, channel 1, c-wave, longitudinal
  mm1 = tool_get_maturity(p_ds, 1, 'min', p_si);
  tt1 = tool_get_timesig(p_ds, 1, 'usec');
  yy1 = tool_get_magnitude(p_ds, 1, 'volts', p_si);
  
  ## signal data, channel 2, s-wave, transversal
  mm2 = tool_get_maturity(p_ds, 2, 'min', p_si);
  tt2 = tool_get_timesig(p_ds, 2, 'usec');
  yy2 = tool_get_magnitude(p_ds, 2, 'volts', p_si);
  
  ## define colormap
  nsig = numel(p_si);
  colmap = viridis(nsig);
  
  ## create figure object
  r_fh = tool_create_figure(p_ss, '2D plot', 'show');
  
  ## plot channel 1, c-wave
  ah1 = tool_create_axes(r_fh, p_ss, 1, 'subplot', '2d');
  ph1 = zeros(1, nsig);
  hold on;
  for i = 1 : max(size(p_si))
    ## vary color
    if (nsig > 1)
      ## update settings, line color
      p_ss.p2d.lcol(1, :) = colmap(i, :);
    endif
    leg = sprintf('%s_{%d}: %d min', p_ss.chshort{1}, p_si(i), mm1(i));
    ph1(i) = tool_create_plot2d(ah1, p_ss, 1, tt1, yy1(:, i), leg);
  endfor
  title(ah1, sprintf('%s - %s', p_ss.temp.dscodeplt, p_ss.chname{1}));
  hold off;
  
  ## channel 2, s-wave
  ah2 = tool_create_axes(r_fh, p_ss, 2, 'subplot', '2d');
  ph1 = zeros(1, nsig);
  hold on;
  for i = 1 : max(size(p_si))
    ## vary color
    if (nsig > 1)
      ## update settings, line color
      p_ss.p2d.lcol(2, :) = colmap(i, :);
    endif
    leg = sprintf('%s_{%d}: %d min', p_ss.chshort{2}, p_si(i), mm2(i));
    ph2(i) = tool_create_plot2d(ah2, p_ss, 2, tt2, yy2(:, i), leg);
  endfor
  title(ah2, sprintf('%s - %s', p_ss.temp.dscodeplt, p_ss.chname{2}));
  hold off;
  
  ## return axes object handles
  r_ah = [ah1, ah2];
  
  ## return plot handles
  r_ph = [ph1, ph2];
  
endfunction
