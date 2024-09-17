import os
import subprocess
import pdb   # For debugging - stops the script execution w/o closing python and maintaining the variables. Put "pdb.set_trace()" where I wanna stop
#pdb.set_trace()

#######################################
##############_READ THIS_##############
#######################################
#
#1. The genome files needs to be in the same folder of this script.
#2. If you got errors, try to execute this:
#       export PERL5LIB=/home/psouza/miniconda3/EDTA/share/RepeatMasker/
#       export PERLLIB=$PERLLIB:/psouza/miniconda3/EDTA/share/RepeatMasker/
#3. Change the array "genomes" according to your species: i.e. Apis mellifera (AMEL); Drosophila melanogaster (DMEL).
#4. Execute:
#       python 1-RepeatMasker-script.py
#
#######################################
##############_READ THIS_##############
#######################################

#Change the name of spp. and modify (if necessary).
#see step "3."
genomes = ['ACER', 'AMEL', 'BLUC', 'BTER', 'FVAR','HLAB', 'LMOR', 'MEUR', 'MLIG', 'MWIL', 'MBEE', 'MQUA', 'NTES', 'NFUC', 'NFAB', 'OBIC', 'PAIL', 'PDRO', 'SBIP', 'SPHA', 'TCAR']

#Rename "EDTA-output" or use the same name
#This name needs to be the same in the server
output_folders = []
for file in os.listdir('.'):
    if file.startswith('EDTA-output'):
        output_folders.append(str(file))
#alphabetical        
output_folders = sorted(output_folders)

#
genomes_files =[]
for file in os.listdir('.'):
    if file.endswith('.fa'):
        genomes_files.append(str(file))
    if file.endswith('.fna'):
        genomes_files.append(str(file))
    if file.endswith('.fasta'):
        genomes_files.append(str(file))

#pdb.set_trace()

genomes_files = sorted(genomes_files)


repeats = []
for j in range(0, len(output_folders)):
    for file in os.listdir(output_folders[j]):
        if file.endswith('TElib.fa'):
            repeats.append(str('./'+output_folders[j]+'/'+file))       


        
for i in range (3,4):#len(output_folders)):
    print('rodando comandos do ' + genomes[i])
    command_1 = 'RepeatMasker -pa 80 -s -a -inv -norna -nolow -no_is -xsmall -dir RepeatMasker-output-'+ genomes[i] +'/ -gff -div 40 -lib '+ repeats[i]+ ' -cutoff 225 '+genomes_files[i]
    print(command_1)
    os.system(command_1)
#    RepeatMasker -pa 50 -s -a -inv -norna -nolow -no_is -xsmall -dir RepeatMasker-output-ACER/ -gff -div 40 -lib repeats[i] -cutoff 225 genomes[i]
    #pdb.set_trace()

files_align = []
for j in range(0, len(output_folders)):
    for file in os.listdir('./RepeatMasker-output-'+genomes[j]):
        if file.endswith('.align'):
            files_align.append(str(file)) 
 
for i in range (3,4):#len(output_folders)):   
    os.chdir('./RepeatMasker-output-'+genomes[i])    
    command_2 = 'calcDivergenceFromAlign.pl -s '+genomes[i]+'.divsum '+files_align[i]
    os.system(command_2)
    os.chdir('..')
    #pdb.set_trace()
#    calcDivergenceFromAlign.pl -s ACER.divsum *.align

for i in range (3,4):#len(output_folders)):
    print(genomes[i])
    print('i='+str(i))
    os.chdir('./RepeatMasker-output-'+genomes[i])
    os.system('pwd')    
    command_3 = 'tail -n 72 '+genomes[i]+'.divsum > '+genomes[i]+'-Kimura-distance.txt'
    #pdb.set_trace()
    print(command_3)
    os.system(command_3)
    os.chdir('..')
#    tail -n 72 ACER.divsum > ACER-Kimura-distance.txt
##end##
    


        
