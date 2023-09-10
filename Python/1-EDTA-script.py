import os
import subprocess
import pdb   # For debugging - stops the script execution w/o closing python and maintaining the variables. Put "pdb.set_trace()" where I wanna stop
#pdb.set_trace()

#######################################
##############_READ THIS_##############
#######################################
#1. Pay attention to the alphabetical order of the files (The array "genomes" needs to be in the same order as the files in the server!)
#2. Change the array "genomes" according to your species: i.e. Apis mellifera (AMEL); Drosophila melanogaster (DMEL).
#3. Install EDTA and example how to run (straight on the command line):
#   
#   git clone https://github.com/oushujun/EDTA.git
#   conda env create -f EDTA.yml
#   conda activate EDTA
#   screen -S EDTA-GENOME
#   perl ../../home/psouza/EDTA/EDTA.pl --genome xxx.fasta --anno 1 --sensitive 1 --threads 80
#
#4. Run these script from genome folder or/and modify the path (your folder).
#5. Activate the environment before runnung the script:
#       conda activate EDTA
#6. Execute:
#       python 1-EDTA-script_corrected.py
#
#######################################
##############_READ THIS_##############
#######################################

#Change the name of spp. and modify (if necessary).
#see step "2."
genomes = ['ACER', 'AMEL', 'BLUC', 'BTER', 'FVAR','HLAB', 'LMOR', 'MEUR', 'MLIG', 'MWIL', 'MBEE', 'MQUA', 'NTES', 'NFUC', 'NFAB', 'OBIC', 'PAIL', 'PDRO', 'SBIP', 'SPHA', 'TCAR']

#find for genome files in different formats
genomes_files =[]
for file in os.listdir('.'):
    if file.endswith('.fa'):
        genomes_files.append(str(file))
    if file.endswith('.fna'):
        genomes_files.append(str(file))
    if file.endswith('.fasta'):
        genomes_files.append(str(file))
#pdb.set_trace()

#alphabetical
genomes_files = sorted(genomes_files)


for j in range (0, len(genomes)):
    command_s = 'screen -S EDTA-'+ genomes[j]
    print('command_s')
    os.system(command_s)
    
    print('Screens...')
    command_s0 = 'screen -ls'
    print(command_s0)
    os.system(command_s0)
    
    command_1 = 'perl ../../home/fchagas/EDTA/EDTA.pl --genome '+genome_files[j]+ ' --anno 1 --sensitive 1 --threads 80'
    print(command_1)
    os.system(command_1)
        
#end