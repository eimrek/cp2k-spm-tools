#!/bin/bash -l

FOLDER="/scratch/snx3000/keimre/"

List=(
    "cp2k_cnt_12_0/L50-15-h-AA-de/diag/"
    "cp2k_cnt_12_0/L50-15-h-AA-se/diag/"
    "cp2k_cnt_12_0/L50-15-h-AB1-de/diag/"
    "cp2k_cnt_12_0/L50-15-h-AB1-se/diag/"
    "cp2k_cnt_12_0/L50-ideal-de/diag/"
    "cp2k_cnt_12_0/L50-ideal-se/diag/"
    "cp2k_cnt_12_0/L60-12-h-AA/diag/"
    "cp2k_cnt_12_0/L60-12-h-AAx/diag/"
    "cp2k_cnt_12_0/L60-12-h-AAy/diag/"
    "cp2k_cnt_12_0/L60-12-h-ABA02A11/diag/"
    "cp2k_cnt_12_0/L60-12-oxy-AA/diag/"
    "cp2k_cnt_12_0/L60-12-vac-circular/diag/"
    "cp2k_cnt_12_0/L60-12-vac-opt-AA/diag/"
    "cp2k_cnt_12_0/L60-12-vac-opt-AA/diag/"
    "cp2k_cnt_12_0/L100-15-h-AA-se/diag/"
    "cp2k_cnt_12_0/L12-ideal"
    "cp2k_cnt_12_0/L12-ideal-no-ends"
    "cp2k_cnt_12_0/L15-ideal"
    "cp2k_cnt_12_12/L50-ideal/diag/"
)

for DATAPATH in "${List[@]}" 
  do
    echo $FOLDER$DATAPATH
    cp ./cp2k_utilities.py ./ftsts_1d_ldos_from_npz.py ./orbital_analysis_from_npz.py ./run_whole_analysis.sh $FOLDER$DATAPATH
    cd $FOLDER$DATAPATH
    bash ./run_whole_analysis.sh &
  done
