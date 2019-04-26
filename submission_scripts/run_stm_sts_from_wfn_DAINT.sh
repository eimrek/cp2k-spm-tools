#!/bin/bash -l
#SBATCH --job-name="morb_calc"
#SBATCH --nodes=6 # the number of ranks (total)
#SBATCH --ntasks-per-node=12 # the number of ranks per node
#SBATCH --cpus-per-task=1 # use this for threaded applications
#SBATCH --time=06:00:00 
#SBATCH --constraint=gpu
#SBATCH --partition=normal
#SBATCH --account=s904

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export CRAY_CUDA_MPS=1
module load daint-gpu

module load cray-python/3.6.1.1
export PYTHONPATH=$PYTHONPATH:"/users/keimre/soft/ase"

ulimit -s unlimited

SCRIPT_DIR="/users/keimre/atomistic_tools"
BASIS_PATH="/users/keimre/soft/cp2k_5.1_18265/data/BASIS_MOLOPT"

FOLDER=".."
PROJ_NAME="aiida"

# Oldest .xyz file in the folder will be set as the geometry
GEOM=$(ls -tr $FOLDER | grep .xyz | head -n 1)

srun -n $SLURM_NTASKS --mpi=pmi2 python3 $SCRIPT_DIR/stm_sts_from_wfn.py \
  --cp2k_input_file "$FOLDER"/"$PROJ_NAME".inp \
  --basis_set_file $BASIS_PATH \
  --xyz_file "$FOLDER"/$GEOM \
  --wfn_file "$FOLDER"/"$PROJ_NAME"-RESTART.wfn \
  --hartree_file "$FOLDER"/"$PROJ_NAME"-HART-v_hartree-1_0.cube \
  --output_file "./stm.npz" \
  --orb_output_file "./orb.npz" \
\
  --emin -1.0 \
  --emax 1.5 \
\
  --eval_region "G" "G" "G" "G" "n-1.5_C" "p4.0" \
  --dx 0.15 \
  --eval_cutoff 16.0 \
  --extrap_extent 4.0 \
\
  --orb_heights 3.0 6.0 \
  --n_homo_ch 10 \
  --n_lumo_ch 10 \
\
  --isovalues 1e-8 1e-6 \
  --heights 3.0 6.0 \
  --de 0.02 \
  --fwhm 0.04 \
