# VPAEM (Vertical Plane Analytic Element Model)
The Vertical Plane Analytic Element Model (VPAEM) is a computer program used to model groundwater flow in the vertical plane. The program includes multiple groundwater features, e.g. fractures, cavities, inhomogeneities and more. It is written in ´C++´ and is run through a *MATLAB* script.

The program has been developed based on the limitless analytic element introduced in Strack (2018) and include:
- constant pressure elements
- inhomogeneities
- drainging fracutres
- blocking fractures
- wells

This program has been developed using *MATLAB* and *Microsoft Visual Stuido*; only the `.m`-, `.cpp`- and `.exe`-files are included in the repository. The solution also uses the Eigen library (Guennebaud & Jacob, 2010).

## Instructions
The plots are generated using the MATLAB program `run_VPGM.m`. The script automatically calls the ´C++´ program which solves the system and plots the results. To run the program simply run the MATLAB script.

## Input data
This list contains all the definitions of the user input data defined in `run_VPGM.m`. These are the model properties:
- text

These are the plotting properties:
- `xfrom` the starting value for x-axis
- `xto` the end value for the x-axis
- `yfrom` the starting value for the y-axis
- `yto` the end value for the y-axis
- `Nx` the number of grid points in the x-diraction
- `Ny` the number of grid points in the y-direction

## Plotting functions
The following functions are included for the plotting scheme in MATLAB
- `creat_figure.m` creat the figure window
- `Plot_line.m` plots a line from `z1` to `z2`

## Citations
The program has been used in the following paper:
- Comming soon.

## References
Strack, O. D. L. (2018). Limitless analytic elements. *Water Resources Research*, 54(2), 1174-1190.
Guennebaud, G., Jacob, B., et al. (2010). *Eigen v3*. http://eigen.tuxfamily.org.

