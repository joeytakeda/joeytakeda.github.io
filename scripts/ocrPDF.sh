#!/bin/bash

# Created by Joey Takeda.
# This script takes in a PDF and uses tesseract and convert (through ImageMagick)
# to create an OCR'd version of the PDF. It does so with density of 300.


#PDF is the input PDF
PDF="$1";
PDF_NAME="${PDF%%.pdf}";
echo $PDF_NAME;
#Set an empty variable here.
PROCESS_FILES="";
if [[ -f $PDF && $PDF == *pdf ]]; then
	echo "Converting" $1;
	echo "Splitting PDF into multiple PNG files.";
	mkdir temp;
	convert -density 300 $PDF temp/$PDF_NAME.png;
	
	echo "Now taking those split PDFs and OCRing.";
	for i in temp/*.png;
	do tesseract $i ${i:-4} pdf;
	done;
	
	#Now combining PDFs
	
	#First get all the file names
	cd temp;
	ls *.png.pdf > listOfFiles.txt;
	
	
	while read line; do 
		PROCESS_FILES+=$line" "
	done < listOfFiles.txt;
	
	#Now combine them using pdfunite
	pdfunite $PROCESS_FILES ../$PDF_NAME"_ocr.pdf";
	
	# rm -r temp
	
	echo "Process completed: " time;
else
	echo "Error PDF file needed."
	echo "Sample command: ocrPdf filename.pdf";
		
fi;
done;