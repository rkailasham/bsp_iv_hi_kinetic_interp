#!/bin/bash

###############################################################
# 2-AUG-2019
 # Written by R. Kailasham
# Going meta on the single-chain code submission script.
# Writing a bash script that would generate "inputc.dat",
# create subfolders, and submit executables from each of
# the subfolders
##############################################################

cur=`pwd`
# This folder must contain the "sens" executable

# Important flags/parameters
sp_type=2
nbeads=10
sqrtb=10.
qos=0 #qos is non-zero only when Fraenkel is involved 
varphi=0.
hstar=0.3
rfd_param=1.d-5
ntraj_rfd=5000
listof_gdot="0.03 0.05"
nsamp=50
teq=0.
tpr=100.
dtseq=1.d-3
dtsne=1.d-3
nblock=1300
ntot=9900000

# scarcely used/changed parameters
tol=0.001
bens=0
netcdf=0
res=0
emax=2
EV=0
z_by_eps=1.
dstar=1
ntdone=0
ndelts=1
phiFile=0
phiSDK=0.


## beginning automated folder creation and job submission
narr=64
a=0

for gdot in $listof_gdot ;
do
    mkdir -p $cur/sr_${gdot} ;
    cd $cur/sr_${gdot} ;
    cur2=`pwd`;
    rm -rf inputc.dat;
    echo -e "SpType\tNBeads\tvarphi\th*\tEV\tz*/ε*\t d*\t L0*\t Q0*\tGdot\tBens\tNetCDF\tRestart" >> inputc.dat
    echo -e "${sp_type}\t${nbeads}\t${varphi}\t${hstar}\t${EV}\t${z_by_eps}\t${dstar}\t${sqrtb}\t${qos}\t${gdot}\t${bens}\t${netcdf}\t${res}" >> inputc.dat
    echo -e "emax\tNsamp\tphiFile\tphiSDK\trfd_param\tntraj_rfd\tTeq\tTpr\tNtrajdone" >> inputc.dat
    echo -e "${emax}\t${nsamp}\t${phiFile}\t${phiSDK}\t${rfd_param}\t\t${ntraj_rfd}\t\t${teq}\t${tpr}\t${ntdone}" >> inputc.dat
    echo -e "ndelts" >> inputc.dat
    echo -e "${ndelts}" >> inputc.dat
    echo -e "dtseq\tdtsne\tnblock\tntot\ttol" >> inputc.dat
    echo -e "${dtseq}\t${dtsne}\t${nblock}\t${ntot}\t${tol}" >> inputc.dat
#   Creating the SLURM submit script here
    jname=nb_${nbeads}_varphi_${varphi}_hs_${hstar}_sr_${gdot}  
    rm -rf mysub.sh
    echo -e "#!/bin/bash" >> mysub.sh
    echo -e "#SBATCH --job-name=$jname" >> mysub.sh
    echo -e "#SBATCH --partition=comp" >> mysub.sh
    echo -e "#SBATCH --ntasks=1" >> mysub.sh
    echo -e "#SBATCH --array=1-${narr}" >> mysub.sh
    echo -e "#SBATCH --mem-per-cpu=4gb" >> mysub.sh
    echo -e "#SBATCH --time=0-23:55:00" >> mysub.sh
    echo -e "#SBATCH --error=${jname}.err" >> mysub.sh
    echo -e " " >> mysub.sh
    echo -e "# check that the script is launched with sbatch" >> mysub.sh
    echo -e "if [ \"x\$SLURM_JOB_ID\" == \"x\" ]; then" >> mysub.sh
    echo -e "    echo \"You need to submit your job to the queuing system with sbatch\"" >> mysub.sh
    echo -e "    exit 1" >> mysub.sh
    echo -e "fi" >> mysub.sh
    echo -e " " >> mysub.sh
    echo -e "# Run the job from the directory where it was launched (default)" >> mysub.sh
    echo -e " " >> mysub.sh
    echo -e "# The job command(s): " >> mysub.sh
    echo -e "date=\`date +\"%H:%M:%S on %d %b %Y\"\`" >> mysub.sh
    echo -e "echo " >> mysub.sh
    echo -e "echo \"=========================================\"" >> mysub.sh
    echo -e "echo \"Timing: Commenced at \$date \" " >> mysub.sh
    echo -e "$cur/sens #...\${SLURM_ARRAY_TASK_ID}" >> mysub.sh
    echo -e "sleep 5" >> mysub.sh
    echo -e "date=\`date +\"%H:%M:%S on %d %b %Y\"\`" >> mysub.sh
    echo -e "echo \"Timing: Finished at \$date \" " >> mysub.sh
    echo -e "echo \"=========================================\"" >> mysub.sh
    sleep 3
    sbatch mysub.sh
    a=$((a+1));
done

cd $cur; # come back to parent directory









