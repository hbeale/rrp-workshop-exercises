#!/bin/bash

# set options
set -euo pipefail

# run from the directory where this file lives
# cd "$(dirname ${BASH_SOURCE[0]}")"
cd "$(dirname "${BASH_SOURCE[0]}")"


# set up variables
STUDY_ID=SRP255885
run_id=SRR11518889
fastq_R1="${run_id}_1.fastq.gz"
fastq_R2="${run_id}_2.fastq.gz"
fastq_URL="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR115/089/${run_id}/"
fastq_DEST="../data/raw/fastq/${STUDY_ID}"
TRIMMED_DIR="../data/trimmed/${STUDY_ID}"
REPORTS_DIR="../reports/fastp"

# Create directory to hold FASTQ files from this project
mkdir -p $fastq_DEST $TRIMMED_DIR $REPORTS_DIR

if [ ! -f ${fastq_DEST}/${fastq_R1} ]; then
    # Download the R1 file
    echo ${fastq_URL}/${fastq_R1}
    curl -O ${fastq_URL}/${fastq_R1}

    # move files to destination directory
    mv ${fastq_R1} $fastq_DEST
fi

# Count the lines in the R1 file
echo "The number of lines in $fastq_R1 is:"
gunzip -c ${fastq_DEST}/${fastq_R1} | wc -l 

if [ ! -f ${fastq_DEST}/${fastq_R2} ]; then
    # Download the R2 file
    curl -O ${fastq_URL}/${fastq_R2}

    # move files to destination directory
    mv ${fastq_R2} $fastq_DEST

fi

# Count the lines in the R2 file
echo "The number of lines in $fastq_R2 is:"
gunzip -c ${fastq_DEST}/${fastq_R2} | wc -l 