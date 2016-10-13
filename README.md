# SABR
Sparse, Anchor-Based Representation of speech

## Prerequisites

### STRAIGHT
Technically, you need to have the STRAIGHT library available--I can't redistribute it. That being said, a bugfix version of the library is available at my private repo; email me if you want access:
https://github.tamu.edu/cliberatore/Kawahara-STRAIGHT.git

### rastamat
Dr. Dan Ellis' excellent Matlab speech proccessing toolkit. Available: http://labrosa.ee.columbia.edu/matlab/rastamat/.

## Installation
~~~~
git clone https://github.tamu.edu/cliberatore/SABR.git
~~~~

This will download SABR, PSI-utilities and ARCTIC-toolkit to your current folder, as they are included as submodules to the project.

You need to extract STRAIGHT and rastamat to `.\toolkits\` under folders `STRAIGHT` and `rastamat`.

Download the repository and run config.m in Matlab to configure paths.
