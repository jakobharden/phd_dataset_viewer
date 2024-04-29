## Select and load GNU Octave binary dataset file (*.oct), GUI
##
## FUNCTION SYNOPSIS:
##
## Usage 1: [r_ds] = tool_gui_dsload(p_src)
##                     non-interactive mode
##                     p_src is an already loaded dataset data structure
##
## Usage 2: [r_ds] = tool_gui_dsload(p_src)
##                     non-interactive mode
##                     p_src is a full qualified path to a dataset file (*.oct)
##
## Usage 3: [r_ds] = tool_gui_dsload()
##                     interactive mode
##                     show dataset file selection dialogue, GUI
##
## p_src ... Usage 1: dataset data structure, optional, <struct_dataset>
## p_src ... usage 2: full qualified file path to dataset, optional, <str>
## r_ds  ... return: dataset data structure, <struct>
##
## Note: This function also performs a rough integrity check of the data structure to make sure that the loaded structure truely is a dataset.
##
## see also: dsviewer_settings.m, uigetfile, load
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
function [r_ds] = tool_gui_dsload(p_src)
  
  ## check arguments
  if (nargin < 1)
    p_src = [];
  endif
  if not(isempty(p_src))
    ## check whether function parameter is a structure
    if isstruct(p_src)
      r_ds = p_src;
      hlp_check_structroot(r_ds);
      return;
    endif
    ## check whether given file path exists or not
    if (exist(p_src, 'file') != 3)
      p_src = [];
    endif
  endif
  
  ## select dataset file, GUI
  if isempty(p_src)
    [fname, fpath, fltidx] = uigetfile("*.oct", 'Select binary dataset file (*.oct)');
    p_src = fullfile(fpath, fname);
  endif
  
  ## load dataset
  r_ds = load(p_src, 'dataset');
  
  ## check dataset
  hlp_check_dataset(r_ds);
  
  ## resolve structure root
  r_ds = r_ds.dataset;
  
  ## check structure root
  hlp_check_structroot(r_ds);
  
endfunction

function hlp_check_dataset(p_ds)
  ## Check dataset data structure
  ##
  ## p_ds ... dataset data structure, <struct_dataset>
  
  if not(isfield(p_ds, 'dataset'))
    help tool_gui_dsload;
    error('Structure does not contain the substructure: "dataset"!');
  endif
  
endfunction

function hlp_check_structroot(p_ds)
  ## Check dataset data structure
  ##
  ## p_ds ... dataset data structure, <struct_dataset>
  
  if not(isfield(p_ds, 'obj'))
    help tool_gui_dsload;
    error('Structure has no field: "obj"!');
  endif
  if not(strcmp(p_ds.obj, 'struct_dataset'))
    help tool_gui_dsload;
    error('Object type not equal to "struct_dataset"!');
  endif
  
endfunction
