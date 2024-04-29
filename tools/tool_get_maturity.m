## Get maturity time array from ultrasonic test substructure of a dataset
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_ma] = tool_get_maturity(p_ds, p_cn, p_um, p_si)
##                     non-interactive mode
##
## Usage 2: [r_ma] = tool_get_maturity(p_ds, p_cn, p_um, [])
##          [r_ma] = tool_get_maturity(p_ds, p_cn, p_um)
##                     non-interactive mode
##                     return maturity for all signals
##
## Usage 3: [r_ma] = tool_get_maturity(p_ds, p_cn, [], p_si)
##                     non-interactive mode
##                     return maturity in Minutes
##
## p_ds ... dataset data structure or ultrasonic test substructure, <struct_dataset> or <struct_test_utt>
## p_cn ... channel number, <uint>
##            0: channel is already selected, p_ds is a ultrasonic test substructure <struct_test_utt>
##            1: channel 1, compression wave, longitudinal
##            2: channel 2, shear wave, transversal
##            3: both channels, use sample time signature from channel 1
## p_um ... unit mode, optional, default = "min", <str>
##            "sec": return values in seconds
##            "min": return values in minutes, integral numbers (fixed), default mode
##            "minfloat": return values in minutes, floating point numbers
## p_si ... signal index or signal index array, optional, <uint> or [<uint>]
## r_ma ... return: maturity time array [nsig x 1], [<dbl>]
##
## Note: For cement paste tests, the time span between adding water to the cement and the start of the ultrasonic test ("zero-time", t0) 
##       is different from zero. That value (t0) is added to the maturity time array to receive the effective maturity.
##
## see also: dsviewer_2d.m, dsviewer_3d.m, dsviewer_mp4.m, dsviewer_tem.m
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
function [r_ma] = tool_get_maturity(p_ds, p_cn, p_um, p_si)
  
  ## check arguments
  if (nargin < 2)
    help tool_get_maturity;
    error('Less arguments given!');
  endif
  if (nargin < 3)
    p_um = [];
  endif
  if (nargin < 4)
    p_si = [];
  endif
  
  ## set default values
  if isempty(p_um)
    p_um = 'min';
  endif
  
  ## switch channel
  switch (p_cn)
    case 0
      ## channel is already selected (see also dsviewer_mp4.m)
      subds = p_ds;
    case 1
      ## channel 1, compression wave
      subds = p_ds.tst.s06;
    case 2
      ## channel 2, shear wave
      subds = p_ds.tst.s07;
    case 3
      ## for combined plots, use maturity of channel 1
      subds = p_ds.tst.s06;
    otherwise
      help tool_get_maturity;
      error('Selected channel number %d is not defined!', p_cn);
  endswitch
  ## zero-time
  t0 = subds.d02.v;
  ## maturity
  if isempty(p_si)
    mm = subds.d11.v;
  else
    mm = subds.d11.v(p_si);
  endif
  
  ## return effective maturity
  ## switch unit mode
  switch (p_um)
    case 'sec'
      r_ma = t0 + mm;
    case 'min'
      r_ma = fix((t0 + mm) / 60.0);
    case 'minfloat'
      r_ma = (t0 + mm) / 60.0;
    otherwise
      help tool_get_maturity;
      error('Selected unit mode %d is not defined!', p_um); 
  endswitch
  
endfunction
