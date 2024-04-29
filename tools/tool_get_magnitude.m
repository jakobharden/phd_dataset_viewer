## Get signal sample magnitude matrix from dataset or ultrasonic test substructure
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_mm] = tool_get_magnitude(p_ds, p_cn, p_um, p_si)
##                     non-interactive mode
##
## Usage 2: [r_mm] = tool_get_magnitude(p_ds, p_cn, p_um, [])
##          [r_mm] = tool_get_magnitude(p_ds, p_cn, p_um)
##                     non-interactive mode
##                     return all samples of signal(s)
##
## Usage 3: [r_mm] = tool_get_magnitude(p_ds, p_cn, [], p_si)
##                     non-interactive mode
##                     return signal sample magnitudes in Volts
##
## p_ds ... dataset data structure or ultrasonic test substructure, <struct_dataset> or <struct_test_utt>
## p_cn ... channel number, <uint>
##            0: channel is already selected, p_ds is a ultrasonic test substructure <struct_test_utt>
##            1: channel 1, compression wave, longitudinal
##            2: channel 2, shear wave, transversal
## p_um ... unit mode, optional, default = "volts" <str>
##            "volts": return values in Volts
##            "mvolts": return values in milli-Volts
##            "uvolts": return values in micro-Volts
## p_si ... signal index or signal index array, optional, <uint> or [<uint>]
## r_mm ... return: signal sample magnitude matrix [nsmp x nsig], [<dbl>]
##
## see also: dsviewer_2d.m, dsviewer_3d.m, dsviewer_mp4.m
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
function [r_mm] = tool_get_magnitude(p_ds, p_cn, p_um, p_si)
  
  ## check arguments
  if (nargin < 2)
    help tool_get_magnitude;
    error('Less arguments given!');
  endif
  if (nargin < 3)
    p_um = [];
  endif
  if (nargin < 4)
    p_si = [];
  endif
  if isempty(p_um)
    p_um = 'volts';
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
    otherwise
      help tool_get_magnitude;
      error('Selected channel number %d is not defined!', p_cn);
  endswitch
  if isempty(p_si)
    ## return all signals
    mm = subds.d13.v;
  else
    ## return selected signals only
    mm = subds.d13.v(:, p_si);
  endif
  
  ## switch unit mode
  switch (p_um)
    case 'volts'
      r_mm = mm;
    case 'mvolts'
      r_mm = mm * 1e3;
    case 'uvolts'
      r_mm = mm * 1e6;
    otherwise
      help tool_get_magnitude;
      error('Selected unit mode %d is not defined!', p_um); 
  endswitch
  
endfunction
