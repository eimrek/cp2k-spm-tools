#!/bin/bash -l

FOLDER=".."
PROJ_NAME="PROJ"

# Oldest .xyz file in the folder will be set as the geometry
GEOM=$(ls -tr $FOLDER | grep .xyz | head -n 1)

mpirun -n 4 stm_sts_from_wfn.py \
  --cp2k_input_file "$FOLDER"/cp2k.inp \
  --basis_set_file "$FOLDER"/BASIS_MOLOPT \
  --xyz_file "$FOLDER"/$GEOM \
  --wfn_file "$FOLDER"/"$PROJ_NAME"-RESTART.wfn \
  --hartree_file "$FOLDER"/"$PROJ_NAME"-HART-v_hartree-1_0.cube \
  --output_file "./stm.npz" \
  --orb_output_file "./orb.npz" \
\
  --eval_region "G" "G" "G" "G" "n-1.5_C" "p3.5" \
  --dx 0.15 \
  --eval_cutoff 16.0 \
  --extrap_extent 4.0 \
  --p_tip_ratios 0.0 \
\
  --n_homo 5 \
  --n_lumo 5 \
  --orb_heights 3.0 4.5 \
  --orb_isovalues 1e-7 \
  --orb_fwhms 0.02 0.1 \
\
  --energy_range -0.5 0.5 0.05 \
  --heights 3.0 \
  --isovalues 1e-7 \
  --fwhms 0.1 \

stm_sts_plotter.py --orb_npz orb.npz --stm_npz stm.npz

