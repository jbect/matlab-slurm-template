#!/bin/bash
#
# Adapt these SLURM directives to your setting:
# #SBATCH --account=XXX
#SBATCH --job-name=test-job
#SBATCH --output=%x_TaskID%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=cpu_med
#SBATCH --time=03:59:00

export LANG=C

echo
echo "  ***"
echo "  ***  Starting at: `date`"
echo "  ***"
echo


####################
##  Module names  ##
####################

## Adapt this to your setting:
MODULE_GIT="git/2.39.1/gcc-11.2.0-tcltk"
MODULE_MATLAB="matlab/R2022a/intel-20.0.4.304"


################################
##  Display host information  ##
################################

hostnamectl
echo


############################
##  Git repo information  ##
############################

echo "  ***"
echo "  *** Git repo information"
echo "  ***"
echo

echo "[`date +%H:%M:%S`] Loading git module..."
module purge
module load ${MODULE_GIT}
echo

git show -s
echo

git status
echo


#######################
##  Job information  ##
#######################

echo "  ***"
echo "  ***  SLURM_JOB_NAME:       ${SLURM_JOB_NAME}"
echo "  ***  SLURM_JOB_ID:         ${SLURM_JOB_ID}"
echo "  ***  SLURM_ARRAY_TASK_ID:  ${SLURM_ARRAY_TASK_ID}"
echo "  ***"
echo

# Check current directory
if [ ! -f "`pwd`/main_script.m" ]; then
    echo "Please start the job from the directory that contains main_script.m"
    exit 1
fi


##################
##  Matlab job  ##
##################

echo "[`date +%H:%M:%S`] Loading matlab module..."
module load ${MODULE_MATLAB}
echo

# Run
echo "[`date +%H:%M:%S`] Starting matlab job..."
matlab -singleCompThread -nojvm -batch "run main_script.m"


###############
##  The end  ##
###############

echo
echo "  ***"
echo "  ***  Finishing at: `date`"
echo "  ***"
echo
