#!/bin/bash

set -e


### designed to run with 12 threads (-t 12 option in bwa and --threads in AdapterRemoval2) - use following command

#
#fastq1File=/mnt/c/projects/aDNA/pipeTest/K14_9_GATCAG.PE.R1.fastq.gz
#fastq2File=/mnt/c/projects/aDNA/pipeTest/K14_9_GATCAG.PE.R2.fastq.gz
#baseDir=/mnt/c/projects/aDNA/pipeTest
#sampName=K14
#libName=9_GATCAG
#runName=hiseq_pe
#platform=hiseq
#adaptFSeq=tru6
#adaptRSeq=tru0
#seqOrigin=willerslev
#
#aDNAfastqMAPpe.sh -1 ${fastq1File} -2 ${fastq2File} -b ${baseDir} -n ${sampName} -l ${libName} -u ${runName} -p ${platform} -o ${seqOrigin} -f tru6 -r tru0



show_help() {
cat << EOF

########################################  HELP PAGE #######################################################
An aDNA pipeline script from the Anthropology deCODE group used to trim and map paired-end aDNA reads from a fastq file. 
Values must be provided for options marked (*) 

    -1 fastq1File       (*) the R1 fastq or fastq.gz file that is to be trimmed and mapped
    -2 fastq2File       (*) the R2 fastq or fastq.gz file that is to be trimmed and mapped
    -f adaptFSeq        (*) can be either full adapter sequences (as read by AdapterRemoval) or abbreviations trushort or tru6 (AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG), tru7 or tru8 where number indicates length of index
    -r adaptRSeq        (*) can be either full adapter sequences (as read by AdapterRemoval) or abbreviations trushort, tru0 for AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT or tru6 for AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTNNNNNNGTGTAGATCTCGGTGGTCGCCGTATCATT or tru7 or tru8 where number indicates length of index
    -n sampName         (*) name of the sample (used as folder name: baseDir/sampName)
    -b baseDir          (*) the directory where the sampName folder exists or will be created
    -l libName          (*) name of the library (used as folder name: baseDir/sampName/seqruns/libName)
    -u runName          (*) name of the sequence run (used as folder name: baseDir/sampName/seqruns/libName/runName)
    -p platform         (*) sequecning technology used to generate fastq file(s) - e.g. miseq, GA2, hiseq, hiseq2500, novaseq, ls454, novaseqxplus
    -o seqOrigin        (*) source of sequencing data, e.g. decode, anders, gilbert, willerslev
    -k capture          (*) capture approach, e.g. 1240k - if no capture was performed (i.e. the data is shotgun sequenced) write no
    -z preseq           run preseq to estimate the complexity of the library
    -g polyGtrim        for Illumina NextSeq/NovaSeq data, polyG can happen in read tails since G means no signal in the Illumina two-color systems. fastp can detect the polyG in read tails and trim them ((no value))
    -a seqID            sequencing ID, e.g.PN
    -i runInfo          additional relevant information about this sequence run, e.g. USER treatment, SNP or WGS capture, additional amplification, etc.
    -e publication      publication associated with this sequence run
    -x fqCopy           copy fastq file 
    -q mQual            threshold for mapping quality used for sex estimation, x contamination and mtDNA pipeline (default: ${mQual})
    -w readLength       minimal readlength equal to (default: ${readLength})
    -d qbase            for qualitybase option of AdapterRemoval (default: ${qbase}). Can bet set to 33, 64 or solexa
    -0 coreSourceFile   file with core functions used in aDNA pipeline scripts (default: ${coreSourceFile}). This can be changed to run the script on another system
    -s softSourceFile   file with the paths of software used by the script (default: ${softSourceFile}). This can be changed to run the script on another system
    -y fileSourceFile   file with the paths of files used by the script (default: ${fileSourceFile}). This can be changed to run the script on another system or with a different reference genome
    -v runMode          run on cluster, local, generate rpdb (use rp) (default: /odinn/groups/ant/data/aDNA/admin/rpdb/(dateSTR)_path2cmdFiles.rpdb, change name with -j option) or just create script and do not run (cluster, local, rp or script - default: ${runMode})
    -j rpdb             basename and full path to the directory where the rpdb exists (if the aim is to add to it) or will be created (default: /odinn/groups/ant/data/aDNA/admin/rpdb/(dateSTR)_path2cmdFile.rpdb) 
    -c threadCnt        number of threads to use in processing (default: ${threadCnt})
    -t jobTime          the time limit of the jobs on the cluster (default: ${jobTime})
    -m jobMem           the memory limit of the jobs on the cluster (default: ${jobMem})
    -h HELP             display this help and exit

EOF
}

procLabel="mpPE"
dateSTR=$(date +'%d-%m-%Y')

coreSourceFile=/odinn/groups/ant/scripts/ant_pipes/aDNApipe_coreFunctions.sh
softSourceFile=/odinn/groups/ant/scripts/ant_pipes/aDNApipe_decode_software_source.sh
fileSourceFile=/odinn/groups/ant/scripts/ant_pipes/aDNApipe_decode_humanB38_source.sh
seqID=""
runInfo=""
publication=""
mQual=20
readLength=25
qbase=33
fqCopy=0
runMode="cluster"
jobTime=300:00:00
jobMem=100000
threadCnt=24
polyGtrim=0
preseq=0
rpdb="/odinn/groups/ant/data/aDNA/admin/rpdb/${dateSTR}_path2cmdFiles.rpdb"

while getopts 1:2:f:r:n:b:l:u:p:xo:k:ga:zq:w:d:0:s:y:v:j:c:t:m:i:e:h opt; do
    case $opt in
        h)  show_help
            exit 0
            ;;
        1)  fastq1File="$OPTARG"
            ;;
        2)  fastq2File="$OPTARG"
            ;;
        f)  adaptFSeq="$OPTARG"
            ;;
        r)  adaptRSeq="$OPTARG"
            ;;
        n)  sampName="$OPTARG"
            ;;
        b)  baseDir="$OPTARG"
            ;;
        l)  libName="$OPTARG"
            ;;
        u)  runName="$OPTARG"
            ;;
        p)  platform="$OPTARG"
            ;;
        o)  seqOrigin="$OPTARG"
            ;;
        k)  capture="$OPTARG"
            ;;
        g)  polyGtrim=1
            ;;
        a)  seqID="$OPTARG"
            ;;
        i)  runInfo="$OPTARG"
            ;;
        e)  publication="$OPTARG"
            ;;
        x)  fqCopy=1
            ;;
        z)  preseq=1
            ;;
        q)  mQual="$OPTARG"
            ;;
        w)  readLength="$OPTARG"
            ;;
        d)  qbase="$OPTARG"
            ;;
        0)  coreSourceFile="$OPTARG"
            ;;
        s)  softSourceFile="$OPTARG"
            ;;
        y)  fileSourceFile="$OPTARG"
            ;;
        v)  runMode="$OPTARG"
            ;;
        j)  rpdb="$OPTARG"
            ;;
        c)  threadCnt="$OPTARG"
            ;;
        t)  jobTime="$OPTARG"
            ;;
        m)  jobMem="$OPTARG"
            ;;
        *)  show_help >&2
            exit 1
            ;;
    esac
done

if [[ $# -eq 0 ]]; then
    show_help >&2
    exit 1
fi


# these files contain the paths to all software and key files
source ${coreSourceFile}


### run check of values for obligatory variables - extend this!!
echo -e "\n## Checking input variables..."
checkOpt 1 fastq1File ${fastq1File}
checkOpt 2 fastq2File ${fastq2File}
checkOpt n sampName ${sampName}
checkOpt b baseDir ${baseDir}
checkOpt l libName ${libName}
checkOpt u runName ${runName}
checkOpt p platform ${platform}
checkOpt o seqOrigin ${seqOrigin}
checkOpt f adaptFSeq ${adaptFSeq}
checkOpt r adaptRSeq ${adaptRSeq}
checkOpt k capture ${capture}

echo -e "OK\n"


#dateSTR=$(date +'%d-%m-%Y')


# these files contain the paths to all software and key files
source ${softSourceFile}
source ${fileSourceFile}


## check for presence of key software - abort if not present
## check for presence of key software
fileNotFoundAbort ${adapterRemovalpath} 'AdapterRemoval not found. Correct path must be specified in softSourceFile'
fileNotFoundAbort ${bwapath} 'bwa not found. Correct path must be specified in softSourceFile'
fileNotFoundAbort ${samtoolspath} 'samtools not found. Correct path must be specified in softSourceFile'


# check for presence of fastq files
fileNotFoundAbort ${fastq1File} 'fastq1File not found'
fileNotFoundAbort ${fastq2File} 'fastq2File not found'



### define and make directories
sampDir=${baseDir}/${sampName}
libDir=${sampDir}/seqruns/${libName}
runDir=${libDir}/${runName}
fastqDir=${runDir}/fastq
bamDir=${runDir}/bam
basename=${libName}_${runName}
#rpdbdir=$(dirname ${baseDir})/admin/rpdb

checkMapDir

#mkdir -p ${sampDir}
#mkdir -p ${sampDir}/seqruns
#mkdir -p ${libDir}
#mkdir -p ${runDir}
mkdir -p ${fastqDir}
mkdir -p ${bamDir}


fq1use=${fastqDir}/${basename}.R1.fastq.gz
fq2use=${fastqDir}/${basename}.R2.fastq.gz


### initiate cmdFile and slurmOutFile
slurmOutFile=${runDir}/${basename}_fastqMAPpe_${dateSTR}_slurm_out.txt
cmdFile=${runDir}/${basename}_fastqMAPpe_${dateSTR}.sh

#printf '#!/bin/bash\n' > ${cmdFile}
#echo -e "\n#### SET KEY VARIABLES AND PATHS ####"  >> ${cmdFile}

## INITIATE ${cmdFile}
writeMapDirPaths ${cmdFile}

echo 'echo "############################################################"' >> ${cmdFile}
echo 'echo "hostname: $(hostname)"' >> ${cmdFile}
echo 'echo "slurm_job_id: ${SLURM_JOB_ID}"' >> ${cmdFile}

echo 'echo "###### running aDNAfastqMAPpe for ${basename} on ${dateSTR}"' >> ${cmdFile}
echo 'echo "fastqDir: ${fastqDir}"' >> ${cmdFile}
echo 'echo "bamDir: ${bamDir}"' >> ${cmdFile}

writeMapSoftwarePaths ${cmdFile}
writeFilePaths ${cmdFile}


echo 'echo -e "\n\n"' >> ${cmdFile}

# determine the adapters to use for trimming
echo "# adaptFSeq was given as ${adaptFSeq}" >> ${cmdFile}
procFAdaptSeq ${adaptFSeq}
echo "adaptFSeq=${adaptFSeq}" >> ${cmdFile}

echo "# adaptRSeq was given as ${adaptRSeq}" >> ${cmdFile}
procRAdaptSeq ${adaptRSeq}
echo "adaptRSeq=${adaptRSeq}" >> ${cmdFile}

echo 'echo -e "\n\n"' >> ${cmdFile}

echo -e "\n#### COPY OR MAKE LINKS TO FASTQ FILES ####"  >> ${cmdFile}

# either copy fastq files or make symbolic links
if [ ${fqCopy} -eq 0 ]; then
  echo 'ln -s ${fastq1File} ${fq1use}' >> ${cmdFile}
  echo 'ln -s ${fastq2File} ${fq2use}' >> ${cmdFile}
else 
  echo 'cp ${fastq1File} ${fq1use}' >> ${cmdFile}
  echo 'cp ${fastq2File} ${fq2use}' >> ${cmdFile}
  echo 'echo "${fastq1File}" > ${fastqDir}/${basename}_origfastq.txt' >> ${cmdFile}
  echo 'echo "${fastq2File}" >> ${fastqDir}/${basename}_origfastq.txt' >> ${cmdFile}
fi

## write mapping info to file - if some of these files are not created - then there has been a problem with the mapping
writeMapInfoFile ${cmdFile}


#run fastp if NextSeq/NovaSeq seq data else not

if [ ${polyGtrim} -eq 1 ]; then
  echo -e "\n#### RUN FASTP ####"  >> ${cmdFile}
  echo '${fastppath} --in1 ${fq1use} --in2 ${fq2use} --out1 ${fastqDir}/${basename}.R1.pG.fastq.gz --out2 ${fastqDir}/${basename}.R2.pG.fastq.gz -A -g -Q -L -w 12 --json  ${fastqDir}/${basename}_polyg_fastp.json --html ${fastqDir}/${basename}_polyg_fastp.html' >> ${cmdFile}
  echo 'fq1use=${fastqDir}/${basename}.R1.pG.fastq.gz' >> ${cmdFile}
  echo 'fq2use=${fastqDir}/${basename}.R2.pG.fastq.gz' >> ${cmdFile}
fi

echo -e "\n#### TRIM ADAPTER SEQUENCE FROM READS WITH ADAPTERREMOVAL ####"  >> ${cmdFile}
# Run AdapterRemoval2 to trim adapter sequences from reads - deal with single vs double index adapter sequences
## note that the identify-adapters option only works for paired-end sequence data in AdapterRemoval
echo 'echo -e "\n###### Running AdapterRemoval..."' >> ${cmdFile}

### identify adapters
if [ ${qbase} -eq 64 ]; then
  echo '${adapterRemovalpath} --file1 ${fq1use} --file2 ${fq2use} --adapter1 ${adaptFSeq} --adapter2 ${adaptRSeq} --identify-adapters --qualitybase 64 --qualitybase-output 33 --threads ${threadCnt} > ${fastqDir}/${basename}_IdentifyAdapter.txt' >> ${cmdFile}
else
  echo '${adapterRemovalpath} --file1 ${fq1use} --file2 ${fq2use} --adapter1 ${adaptFSeq} --adapter2 ${adaptRSeq} --identify-adapters --threads ${threadCnt} > ${fastqDir}/${basename}_IdentifyAdapter.txt' >> ${cmdFile}
fi
echo '${checkAdapterpath} -i ${fastqDir}/${basename}_IdentifyAdapter.txt -o ${fastqDir}/${basename}_adapterCheck.txt' >> ${cmdFile}

### trim adapters
if [ ${qbase} -eq 64 ]; then
  echo '${adapterRemovalpath} --file1 ${fq1use} --file2 ${fq2use} --adapter1 ${adaptFSeq} --adapter2 ${adaptRSeq} --minlength ${readLength} --trimns --trimqualities --threads ${threadCnt} --qualitybase 64 --qualitybase-output 33 --collapse --preserve5p --mm 3 --gzip --basename ${fastqDir}/${basename}' >> ${cmdFile}
else 
  echo '${adapterRemovalpath} --file1 ${fq1use} --file2 ${fq2use} --adapter1 ${adaptFSeq} --adapter2 ${adaptRSeq} --minlength ${readLength} --trimns --trimqualities --threads ${threadCnt} --collapse --preserve5p --mm 3 --gzip --basename ${fastqDir}/${basename}' >> ${cmdFile}
fi  
  
#Combine single-end fastq files
echo 'echo -e "\n###### Combining trimmed single-end reads to single file..."' >> ${cmdFile}
echo 'cat ${fastqDir}/${basename}.collapsed.gz > ${fastqDir}/${basename}.singleEnd.fastq.gz' >> ${cmdFile}
echo 'cat ${fastqDir}/${basename}.collapsed.truncated.gz >> ${fastqDir}/${basename}.singleEnd.fastq.gz' >> ${cmdFile}
echo 'cat ${fastqDir}/${basename}.singleton.truncated.gz >> ${fastqDir}/${basename}.singleEnd.fastq.gz' >> ${cmdFile}


## check if ${fastqDir}/${basename}.truncated.gz was created
fileNotFoundAbortScript '${fastqDir}/${basename}.singleEnd.fastq.gz' 'Could not find combined single end fastq file. Adapter trimming may have failed' ${cmdFile}



echo -e "\n#### MAP READS WITH BWA AND CREATE BAM FILES ####"  >> ${cmdFile}
## BWA commands - burrows-wheeler alignment steps ####
# mapping of single-end reads direct to bam file
#
echo 'echo -e "\n###### Mapping single-end reads..."' >> ${cmdFile}
echo '${bwapath} aln ${bwaALNparam} -t ${threadCnt} -f ${bamDir}/${basename}.singleEnd.sai ${refFa} ${fastqDir}/${basename}.singleEnd.fastq.gz' >> ${cmdFile}
echo "readGrpSESTR='@RG\tID:${libName}_${runName}_SE\tPL:${platform}\tLB:${libName}\tSM:${sampName}\tDT:${dateSTR}\tCN:${seqOrigin}'" >> ${cmdFile}
echo '${bwapath} samse -r ${readGrpSESTR} ${refFa} ${bamDir}/${basename}.singleEnd.sai ${fastqDir}/${basename}.singleEnd.fastq.gz | ${samtoolspath} view -@ ${addThreadCnt} -b - | ${samtoolspath} sort -@ ${addThreadCnt} -o ${bamDir}/${basename}.singleEnd.bam -' >> ${cmdFile}
#rm ${fastqDir}/${basename}.singleEnd.fastq.gz

# mapping of paired-end reads direct to bam file
echo 'echo -e "\n###### Mapping paired-end reads..."' >> ${cmdFile}
echo '${bwapath} aln ${bwaALNparam} -t ${threadCnt} -f ${bamDir}/${basename}.pair1.truncated.sai ${refFa} ${fastqDir}/${basename}.pair1.truncated.gz' >> ${cmdFile}
echo '${bwapath} aln ${bwaALNparam} -t ${threadCnt} -f ${bamDir}/${basename}.pair2.truncated.sai ${refFa} ${fastqDir}/${basename}.pair2.truncated.gz' >> ${cmdFile}
echo "readGrpPESTR='@RG\tID:${libName}_${runName}_PE\tPL:${platform}\tLB:${libName}\tSM:${sampName}\tDT:${dateSTR}\tCN:${seqOrigin}'" >> ${cmdFile}
echo '${bwapath} sampe -r ${readGrpPESTR} ${refFa} ${bamDir}/${basename}.pair1.truncated.sai ${bamDir}/${basename}.pair2.truncated.sai ${fastqDir}/${basename}.pair1.truncated.gz ${fastqDir}/${basename}.pair2.truncated.gz | ${samtoolspath} view -@ ${addThreadCnt} -b - | ${samtoolspath} sort -@ ${addThreadCnt} -o ${bamDir}/${basename}.pairedEnd.bam -' >> ${cmdFile} 


echo -e "\n#### PROCESS AND MERGE SINGLE AND PAIRED END BAM FILES ####"  >> ${cmdFile}
#create flagstat files for singleEnd and pairedEnd bam files
echo 'echo -e "\n###### get flagstat.info files for singleEnd and pairedEnd bam files..."' >> ${cmdFile}
echo '${samtoolspath} index -@ ${addThreadCnt} ${bamDir}/${basename}.singleEnd.bam' >> ${cmdFile}
echo '${samtoolspath} flagstat -@ ${addThreadCnt} ${bamDir}/${basename}.singleEnd.bam > ${bamDir}/${basename}.singleEnd.flagstat.info' >> ${cmdFile}

echo '${samtoolspath} index -@ ${addThreadCnt} ${bamDir}/${basename}.pairedEnd.bam' >> ${cmdFile}
echo '${samtoolspath} flagstat -@ ${addThreadCnt} ${bamDir}/${basename}.pairedEnd.bam > ${bamDir}/${basename}.pairedEnd.flagstat.info' >> ${cmdFile}

# Merge single and paired-end bam files
echo 'echo -e "\n###### merge singleEnd and pairedEnd bam files..."' >> ${cmdFile}
echo '${samtoolspath} merge -@ ${addThreadCnt} -f ${bamDir}/${basename}.bam ${bamDir}/${basename}.singleEnd.bam ${bamDir}/${basename}.pairedEnd.bam' >> ${cmdFile}
echo '${samtoolspath} index -@ ${addThreadCnt} ${bamDir}/${basename}.bam' >> ${cmdFile}
# check that bam file was created, abort if not
fileNotFoundAbortScript '${bamDir}/${basename}.bam' 'merged bam file with single and paired-end reads not created' ${cmdFile}

echo '${samtoolspath} flagstat -@ ${addThreadCnt} ${bamDir}/${basename}.bam > ${bamDir}/${basename}.flagstat.info' >> ${cmdFile}
echo '${samtoolspath} idxstats -@ ${addThreadCnt} ${bamDir}/${basename}.bam > ${bamDir}/${basename}.idxstats.info' >> ${cmdFile}



echo -e "\n#### MAKE BAM FILE WITH ONLY MAPPED READS AND REMOVE DUPLICATES ####"  >> ${cmdFile}
# create bam file with only mapped reads 
### if we are only using reads with mapping quality >= 30 then why not apply that filter here? Better to use 20? We might want to know how many duplicates we have? i.e. get the duplicates % before filtering 
echo '${samtoolspath} view -@ ${addThreadCnt} -b -F 4 ${bamDir}/${basename}.bam > ${bamDir}/${basename}.mapped.bam' >> ${cmdFile}
echo '${samtoolspath} index -@ ${addThreadCnt} ${bamDir}/${basename}.mapped.bam' >> ${cmdFile}


echo 'echo -e "\n###### calculate average length of mapped reads from bam..."' >> ${cmdFile}
printf '${getReadLenpath} -b ${bamDir}/${basename}.mapped.bam -o ${bamDir}/${basename}.mapped.Average.length.txt -s ${softSourceFile} -0 ${coreSourceFile} -c ${threadCnt}\n' >> ${cmdFile}


#remove duplicates from mapped reads
echo 'echo -e "\n###### remove duplicate reads from merged bam file..."' >> ${cmdFile}
echo '${javapath} -Xmx2g -jar ${picardpath} MarkDuplicates MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 METRICS_FILE=${bamDir}/${basename}.mapped.metrics REMOVE_DUPLICATES=true ASSUME_SORTED=true VALIDATION_STRINGENCY=LENIENT INPUT=${bamDir}/${basename}.mapped.bam OUTPUT=${bamDir}/${basename}.mapped.dedup.bam' >> ${cmdFile}
fileNotFoundAbortScript '${bamDir}/${basename}.mapped.dedup.bam' 'single end bam file with duplicated reads removed not created' ${cmdFile}

echo '${samtoolspath} index -@ ${addThreadCnt} ${bamDir}/${basename}.mapped.dedup.bam' >> ${cmdFile}

# create flagstat and idxstats files for merged mapped and duplicate removed bam files

echo '${samtoolspath} flagstat -@ ${addThreadCnt} ${bamDir}/${basename}.mapped.dedup.bam > ${bamDir}/${basename}.mapped.dedup.flagstat.info' >> ${cmdFile}
echo '${samtoolspath} idxstats -@ ${addThreadCnt} ${bamDir}/${basename}.mapped.dedup.bam > ${bamDir}/${basename}.mapped.dedup.idxstats.info' >> ${cmdFile}


echo -e "\n#### CREATE RESCALED AND FILTERED BAM FILES AND GET VARIOUS STATS ####"  >> ${cmdFile}
echo 'echo -e "\n###### calculate average length of mapped reads from dedup bam..."' >> ${cmdFile}
printf '${getReadLenpath} -b ${bamDir}/${basename}.mapped.dedup.bam -o ${bamDir}/${basename}.mapped.dedup.Average.length.txt -s ${softSourceFile} -0 ${coreSourceFile} -c ${threadCnt}\n' >> ${cmdFile}


echo 'echo -e "\n###### calculating genome coverage with bedtools..."' >> ${cmdFile}
echo '${bedtoolspath} genomecov -ibam ${bamDir}/${basename}.mapped.dedup.bam > ${bamDir}/${basename}.mapped.dedup.genome.coverage.txt' >> ${cmdFile}
echo '${gencovSumpath} -i ${bamDir}/${basename}.mapped.dedup.genome.coverage.txt -c ${chromLenpath} > ${bamDir}/${basename}.mapped.dedup.genomecoverage_summary.txt' >> ${cmdFile}

echo 'echo -e "\n###### calculating 1240k coverage with bedtools..."' >> ${cmdFile}
echo '${bedtoolspath_bioinfo} coverage -abam ${bamDir}/${basename}.mapped.dedup.bam -b ${SNPset1240k} -counts > ${bamDir}/${basename}.mapped.dedup_1240k_SNPs_coverage.txt' >> ${cmdFile}
printf '${DoC1240kpath} -f ${bamDir}/${basename}.mapped.dedup_1240k_SNPs_coverage.txt\n' >> ${cmdFile}

if [ ${preseq} -eq 1 ]; then
  echo -e "\n#### RUN PRESEQ lc_extrap on merged BAM####"  >> ${cmdFile}
  echo 'mkdir -p ${bamDir}/preseq' >> ${cmdFile}
  echo '${preseqpath} lc_extrap -o ${bamDir}/preseq/${basename}.preseq.lc.txt -B ${bamDir}/${basename}.bam 2> ${bamDir}/preseq/${basename}.preseq.lc.err.txt' >> ${cmdFile}
  echo '${preseqSumpath} -i ${bamDir}/preseq/${basename}.preseq.lc.txt -o ${bamDir}/preseq' >> ${cmdFile}
fi

### mapDamage ##
echo 'echo -e "\n###### Run mapDamage and rescale base quality..."' >> ${cmdFile}
echo '${pythonFullPath} ${mapDampath} -i ${bamDir}/${basename}.mapped.dedup.bam -d ${bamDir}/mapDamage -r ${refFa} --rescale --rescale-out=${bamDir}/${basename}.mapped.dedup.rsc.bam' >> ${cmdFile}
echo '${samtoolspath} index -@ ${addThreadCnt} ${bamDir}/${basename}.mapped.dedup.rsc.bam' >> ${cmdFile}

echo 'echo -e "\n###### determine sex using ry..."' >> ${cmdFile}
## make idxstats info with only reads mapping to SexChr with quality >=20
echo '${sexChromCntpath} -b ${bamDir}/${basename}.mapped.dedup.rsc.bam -o ${bamDir}/${basename}.mapped.dedup.rsc.sexChrom.idxstats.info -q ${mQual} -x ${chromX} -y ${chromY} -s ${softSourceFile} -0 ${coreSourceFile}' >> ${cmdFile}
echo '${sexCheckpath} --malelimit ${malelimit} --femalelimit ${femalelimit} -i ${bamDir}/${basename}.mapped.dedup.rsc.sexChrom.idxstats.info -o ${bamDir}/${basename}.mapped.dedup.rsc.sexChrom_rySex.txt' >> ${cmdFile}


echo -e "\n#### RUN mtDNA PIPELINE AND ESTIMATE CONTAMINATION ####"  >> ${cmdFile}
echo 'echo -e "\n###### running mtDNA pipeline..."' >> ${cmdFile}
#echo '${mtPipepath} -b ${bamDir}/${basename}.mapped.dedup.rsc.bam -o ${bamDir} -q ${mQual} -s ${softSourceFile} -y ${fileSourceFile} -0 ${coreSourceFile} -c ${threadCnt}' >> ${cmdFile}
echo '${mtPipepath} -b ${bamDir}/${basename}.mapped.dedup.rsc.bam -o ${bamDir} -s ${softSourceFile} -y ${fileSourceFile} -0 ${coreSourceFile} -c ${threadCnt}' >> ${cmdFile}


###Run angsd ContamX
echo 'echo -e "\n###### running angsd contamination estimate for X ..."' >> ${cmdFile}
echo 'mkdir -p ${bamDir}/contam' >> ${cmdFile}
echo '${angsdpath}/angsd -i ${bamDir}/${basename}.mapped.dedup.rsc.bam -r ${cXbedSTR} -doCounts 1 -iCounts 1 -minMapQ ${mQual} -minQ 20 -out ${bamDir}/contam/${basename}.mapped.dedup.rsc_angsdput' >> ${cmdFile}
#do Fisher´s extract test for finding a p-value, and jackknife to get an estimate of contamination (R progam)
echo '${Rscriptpath} ${angsdpath}/R/contamination.R mapFile="${cXuniqpath}" hapFile="${cXHapMappath}" countFile="${bamDir}/contam/${basename}.mapped.dedup.rsc_angsdput.icnts.gz" mc.cores=${threadCnt} > ${bamDir}/contam/${basename}.mapped.dedup.rsc_Xcontam_angsdR.txt' >> ${cmdFile}

echo 'echo -e "\n###### Finished all processing"' >> ${cmdFile}

echo -e "\n#### RUN SCRIPT LOCALLY OR ON CLUSTER ####"  >> ${cmdFile}

removeMapFiles ${cmdFile}

chmod u+x ${cmdFile}

echo "Created script file: ${cmdFile}"

if [ ${runMode} == "local" ]; then
  echo "run locally..."
  ${cmdFile} &> ${slurmOutFile}
elif [ ${runMode} == "script" ]; then
  echo "only script created. Nothing to run"
elif [ ${runMode} == "rp" ]; then
  echo "scripts created and rpdb"
  #rp -f ${rpdbdir}/${rpdb}.rpdb add -c ${threadCnt} -m ${jobMem} -w ${jobTime} -d ${runDir} -N ${basename}_fastqMAPpe_${dateSTR}_slurm "bash ${cmdFile}"
  rp -f ${rpdb} add -c ${threadCnt} -m ${jobMem} -w ${jobTime} -l --output=${slurmOutFile} -l --error=${slurmOutFile} "bash ${cmdFile}"
else
  echo "send to cluster..."
  jobname="${procLabel}${sampName}"
  echo "${cmdFile}" | xargs -I wrapme sbatch --wrap 'wrapme' --time=${jobTime} --mem=${jobMem} --cpus-per-task=${threadCnt} --output=${slurmOutFile} --error=${slurmOutFile} --job-name=${jobname}

fi
