# Dataset Viewer, version 1.0

The **Dataset Viewer** is a script collection that allows for plotting data from datasets made from measurement data of ultrasonic pulse transmission tests. The main features cover 2D plots, 3D plots and rendering MP4 video files from the measurement data included in the datasets.

[!INFO]
The entire content of this script collection was conceived, implemented and tested by Jakob Harden using the scientific numerical programming language of GNU Octave 6.2.0.


## Table of contents

- License
- Prerequisites
- Directory and file structure
- Installation instructions
- Usage instructions
- Help and Documentation
- Related data sources
- Related software
- Revision and release history


## Licence

All files published under the **DOI 10.3217/c1ccn-8m982** are licenced under the [MIT licence](https://opensource.org/license/mit/).

	Copyright 2023 Jakob Harden (jakob.harden@tugraz.at, Graz University of Technology, Graz, Austria)
	License: MIT
	This file is part of the PhD thesis of Jakob Harden.
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
	documentation files (the “Software”), to deal in the Software without restriction, including without
	limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
	the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	
	THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
	THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## Prerequisites

To be able to use the scripts, GNU Octave 6.2.0 (or a higher version) need to to be installed.
GNU Octave is available via the package management system on many Linux distributions. Windows users have to download the Windows version of GNU Octave and to install the software manually.

[GNU Octave download](https://octave.org/download)

To create MP4 video files (function file: dsviewer_mp4.m) **ffmpeg** need to be installed.

[ffmpeg](https://www.ffmpeg.org/)


## Directory and file structure

All scripts files (*.m) are plain text files written in the scientific programming language of GNU Octave 6.2.0.

```
    dsviewer/   
    ├── dsviewer_2d.m   
    ├── dsviewer_3d.m   
    ├── dsviewer_mp4.m   
    ├── dsviewer_settings.m   
    ├── dsviewer_tem.m   
    ├── examples   
    │   ├── plot2d   
    │   ├── plot3d   
    │   ├── plotmp4   
    │   ├── plottem   
    │   ├── README.html   
    │   └── README.md   
    ├── init.m   
    ├── README.html   
    ├── README.md   
    ├── tmp   
    └── tools   
        ├── tool_create_axes.m   
        ├── tool_create_figure.m   
        ├── tool_create_plot2d.m   
        ├── tool_create_plot3d.m   
        ├── tool_get_dscode.m   
        ├── tool_get_magnitude.m   
        ├── tool_get_maturity.m   
        ├── tool_get_mp4ulim.m   
        ├── tool_get_ptslen.m   
        ├── tool_get_timesig.m   
        ├── tool_gui_dsload.m   
        ├── tool_gui_selchn.m   
        ├── tool_gui_selmp4om.m   
        ├── tool_gui_selsec.m   
        ├── tool_gui_selsig.m   
        ├── tool_gui_seltem.m   
        └── tool_update_plot2d.m   
```

- dsviewer\_2d.m ... function file, Plot 2D view of ultrasonic signal data
- dsviewer\_3d.m ... function file, Plot 3D view of ultrasonic signal data
- dsviewer\_mp4.m ... function file, Plot/Render signal data to MP4 video file
- dsviewer\_settings.m ... function file, Return plot and rendering settings data structure
- dsviewer\_tem.m ... function file, Plot specimen temperature measurement data
- **examples** ... directory, Examples of plots and videos created with this program (see also: examples/README.md)
- init.m ... function file, Initialize program: Dataset Viewer, version 1.0
- README.html ... HTML version of this file
- README.md ... this file
- **tmp** ... directory, temporary directory used to store frames while rendering MP4 video files
- **tools** ... directory, 
  - /tools/tool\_create\_axes.m ... function file, Create axes object and return axes object handle
  - /tools/tool\_create\_figure.m ... function file, Create figure object and return figure object handle
  - /tools/tool\_create\_plot2d.m ... function file, Create 2D plot object and return plot object handle
  - /tools/tool\_update\_plot2d.m ... function file, Update plot coordinates of existing 2D plot object
  - /tools/tool\_gui\_dsload.m ... function file, Select and load GNU Octave binary dataset file (*.oct), GUI
  - /tools/tool\_gui\_selchn.m ... function file, Select channel of ultrasonic pulse transmission test, GUI
  - /tools/tool\_gui\_selmp4om.m ... function file, Select MP4 video output mode, GUI
  - /tools/tool\_gui\_selsec.m ... function file, Select signal section of ultrasonic signal, GUI
  - /tools/tool\_gui\_selsig.m ... function file, Select signal(s) from ultrasonic pulse transmission test, GUI
  - /tools/tool\_gui\_seltem.m ... function file, Select channel of specimen temperature test, GUI
  - /tools/tool\_get\_dscode.m ... function file, Get dataset code from dataset metadata
  - /tools/tool\_get\_magnitude.m ... function file, Get signal sample magnitude matrix from dataset or ultrasonic test substructure
  - /tools/tool\_get\_maturity.m ... function file, Get maturity time array from ultrasonic test substructure of a dataset
  - /tools/tool\_get\_mp4ulim.m ... function file, Get array of upper sample index limits to render MP4 video files
  - /tools/tool\_get\_ptslen.m ... function file, Get length of pre-trigger section (the noise recorded before the trigger-point)
  - /tools/tool\_get\_timesig.m ... function file, Get signal sample time signature array from dataset or ultrasonic test substructure


## Installation instructions

1. Copy the program directory to a location of your choice. e.g. **working_directory**.   
2. Open GNU Octave.   
3. Change the working directory to the program directory. e.g. **working_directory**.   


## Usage instructions

1. Adjust settings in function file: dsviewer_settings.m.   
2. Run GNU Octave.   
3. Initialize program.   
4. Execute any of the function files.   


### Initialize program

The 'init' command initializes the program. This is only required once before executing all the other functions. The command is adding the subdirectories included in the main program directory to the 'path' environment variable.

```
    octave: >> init;   
```


### Execute function file on the command line interface

```
    octave: >> [r_fh, r_ah, r_ph] = dsviewer_2d(p_fp, p_ss, p_cn, p_si);   
    octave: >> [r_fh, r_ah, r_ph] = dsviewer_3d(p_fp, p_ss, p_cn, p_sn);   
    octave: >> [r_fh, r_ah, r_ph] = dsviewer_tem(p_fp, p_ss, p_cn);   
    octave: >> [r_fp] = dsviewer_mp4(p_fp, p_tp, p_ss, p_om);   
```

Note: The functions shown above can be used in interactive or non-interactive mode. The interactive mode is activated when necessary or all parameters are missing. Almost all plot functions are returning the figure handle (fh). That handle can be used to modify the plots and/or to integrate the plot functions into other scripts. The function dsviewer_mp4 returns the file path (fp) of the newly created video file.


## Help and Documentation

All function files contain an adequate function description and instructions on how to use the functions. This documentation can be displayed in the GNU Octave command line interface by entering the following command:

```
    octave: >> help function_file_name;   
```


## Related data sources

Datasets whos content can be plotted with this scripts are made available at the repository of Graz University of Technology under an open license (Creative Commons, CC BY 4.0). The data records enlisted below contain the raw data, the compiled datasets and a technical description of the record content.


### Data records

- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Datasets - Test Series 1, Cement Paste at Early Stages". Graz University of Technology. [doi: 10.3217/bhs4g-m3z76](https://doi.org/10.3217/bhs4g-m3z76)   
- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Datasets - Test Series 3, Reference Tests on Air". Graz University of Technology. [doi: 10.3217/ph0jm-8ax76](https://doi.org/10.3217/ph0jm-8ax76)   
- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Datasets - Test Series 4, Cement Paste at Early Stages". Graz University of Technology. [doi: 10.3217/f62md-kep36](https://doi.org/10.3217/f62md-kep36)   
- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Datasets - Test Series 5, Reference Tests on Air". Graz University of Technology. [doi: 10.3217/bjkrj-pg829](https://doi.org/10.3217/bjkrj-pg829)   
- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Datasets - Test Series 6, Reference Tests on Water". Graz University of Technology. [doi: 10.3217/hn7we-q7z09](https://doi.org/10.3217/hn7we-q7z09)   
- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Datasets - Test Series 7, Reference Tests on Aluminium Cylinder". Graz University of Technology. [doi: 10.3217/azh6e-rvy75](https://doi.org/10.3217/azh6e-rvy75)   


## Related software

### Dataset Compiler, version 1.1:

The referenced datasets are compiled from raw data using a dataset compilation tool implemented in the programming language of GNU Octave 6.2.0. To understand the structure of the datasets, it is a good idea to look at the soure code of that tool. Therefore, it was made publicly available under the MIT license at the repository of Graz University of Technology.

- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Data set compiler (1.1)". Graz University of Technology. [doi: 10.3217/6qg3m-af058](https://doi.org/10.3217/6qg3m-af058)

[!NOTE]
*Dataset Compiler* is also available on **github**. [Dataset Compiler](https://github.com/jakobharden/phd_dataset_compiler)


### Dataset Exporter, version 1.0:

*Dataset Exporter* is implemented in the programming language of GNU Octave 6.2.0 and allows for exporting data contained in the datasets. The main features of that script collection cover the export of substructures to variables and the serialization to the CSV format, the JSON structure format and TeX code. It is also made publicly available under the MIT licence at the repository of Graz University of Technology.

- Harden, J. (2023) "Ultrasonic Pulse Transmission Tests: Dataset Exporter (1.0)". Graz University of Technology. [doi: 10.3217/9adsn-8dv64](https://doi.org/10.3217/9adsn-8dv64)

[!NOTE]
*Dataset Exporter* is also available on **github**. [Dataset Exporter](https://github.com/jakobharden/phd_dataset_exporter)


## Revision and release history

### 2023-08-26, version 1.0

- published/released version 1.0, by Jakob Harden   
- url: [Repository of Graz University of Technology](https://doi.org/10.3217/c1ccn-8m982)   
- doi: 10.3217/c1ccn-8m982   


