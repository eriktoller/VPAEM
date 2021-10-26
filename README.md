![VPAEM logo](https://github.com/eriktoller/VPAEM/blob/main/VPAEM_logo.png)
# VPAEM (Vertical Plane Analytic Element Model)
The Vertical Plane Analytic Element Model (VPAEM) is a computer program for modelling groundwater flow in the vertical plane. The program includes multiple groundwater features, e.g. fractures, cavities, inhomogeneities and more. The program is written in `C++` and run through a *MATLAB* script.

The program uses analytical elements, see Strack (1989, 2003, 2017, 2018), and include:
- constant pressure elements
- inhomogeneities
- drainging fracutres
- blocking fractures
- wells

This program has been developed using *MATLAB* and *Microsoft Visual Stuido*; only the `.m`-, `.cpp`- and `.exe`-files are included in the repository. The program use the Eigen library (Guennebaud & Jacob, 2010).

## Instructions
The plots are generated using the *MATLAB* program `run_VPAEM.m`. The script automatically calls the `C++` program which solves the system and feeds the solution back to *MATLAB* which plots the results. The data is saved as `data_files\simulation_[date]_[version].mat`.

To run a model:
1. Open `run_VPAEM.m` in *MATLAB*
2. Insert your input data in the editor
3. Run the program
4. The progress is printed in the command window and the flow net and pressure contours are ploted automatically

## Input Data
This list contains all the definitions of the input data defined in `run_VPAEM.m`.

### Global Properties
- `W_uni` uniform flow rate (complex)
- `k` hydraulic conductivity of continuum (double)
- `rho` density of groundwtaer (double)
- `g` acceleration due to gravity (double)
- `h` reference elevation (double)
- `zref` coordinates for reference point (complex)
- `fi0` hydraulic head at reference point (double)
### Blocking Fractures
- `z1a` start coordinates for blocking fractures (complex vector)
- `z2a` end coordinates for blocking fractures (complex vector)
- `ka` hydraulic conductivity for blocking fractures (double vector)
- `ba` fracture width for blocking fractures (double vector)
### Draining Fracutres
- `z1b` start coordinates for draining fractures (complex vector)
- `z2b` end coordinates for draining fractures (complex vector)
- `kb` hydraulic conductivity for draining fractures (double vector)
- `bb` fracture width for draining fractures (double vector)
### Constant Pressure Elements
- `z1c` start coordinates for constant pressure elements (complex vector)
- `z2c` end coordinates for constant pressure elements (complex vector)
### Inhomogeneities
- `z1d` start coordinates for inhomogeneity elements (complex vector)
- `z2d` end coordinates for inhomogeneity elements (complex vector)
- `kd` hydraulic conductivity for inhomogeneity elements (double vector)
### Wells
- `zw` coordinates for wells (complex vector)
- `Qw` discharges for wells (double vector)
- `rw` radii of wells (double vector)
### Solver and Ploting Properties
- `ma` number of coefficients for blocking fractures (integer)
- `mfara` number of far-field correction coefficients for blocking fractures (integer)
- `mb` number of coefficients for draining fractures (integer)
- `mfarb` number of far-field correction  coefficients for draining fractures (integer)
- `mc` number of coefficients for constant pressure elements (integer)
- `mfarc` number of far-field correction  coefficients for constant pressure elements (integer)
- `md` number of coefficients for inhomogeneity elements (integer)
- `mfard` number of far-field correction  coefficients for inhomogeneity elements (integer)
- `Nc` number of integral points for constant pressure elements (integer)
- `N` multiplier for number of solution points for blocking fractures, draining fractures and inhomogeneity elements (double)
- `xfrom` starting value for x-axis (double)
- `xto` end value for the x-axis (double)
- `yfrom` starting value for the y-axis (double)
- `yto` end value for the y-axis (double)
- `Nx` number of grid points in the x-diraction (integer)
- `Ny` number of grid points in the y-direction (integer)
- `lvs` number of contour levels

## External Functions
The following functions are necissary for the plotting scheme in *MATLAB*:
- `creat_figure.m` creat the figure window
- `Plot_line.m` plots a line from `z1` to `z2`
- `Plot_cric.m` plots a circle
- `Contour_flow_net.m` contours the flow net
- `Phi_from_fi.m` computes the discharge potiential

## Author
VPAEM is developed by:\
Erik Å.L. Toller\
*Department of Earth Sciences,*\
*Uppsala University, Uppsala, Sweden*\
*ORCID 0000-0002-7793-3998*

## License
VPAEM is licensed under the MIT license (see LICENSE.md).

## Citations
The program has been used in the following paper:
- Comming soon.

## References
Guennebaud, G., Jacob, B., et al. (2010). *Eigen v3*. http://eigen.tuxfamily.org.

Strack, O. D. L. (1989). Groundwater mechanics. prentice hall.

Strack, O. D. L. (2003). Theory and applications of the analytic element method. Reviews of Geophysics, 41(2).

Strack, O. D. (2017). Analytical groundwater mechanics. Cambridge University Press.

Strack, O. D. L. (2018). Limitless analytic elements. *Water Resources Research*, 54(2), 1174-1190.





