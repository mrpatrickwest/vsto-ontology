#!/bin/bash

if [ "$#" != "3" ]
then
    echo "Usage: $0 <script_dir> <ontology_directory> <data_directory>"
    exit 1
fi

sdir=$1
odir=$2
ddir=$3

if [ ! -d $sdir ]
then
    echo "Script Directory $sdir does not exist"
    echo "Usage: $0 <script_dir> <ontology_directory> <data_directory>"
    exit 1
fi

if [ ! -d $odir ]
then
    echo "Ontology Directory $odir does not exist"
    echo "Usage: $0 <script_dir> <ontology_directory> <data_directory>"
    exit 1
fi

if [ ! -d $ddir ]
then
    echo "Data Directory $ddir does not exist"
    echo "Usage: $0 <script_dir> <ontology_directory> <data_directory>"
    exit 1
fi

ONTOLOGIES=`ls $odir/*.owl`
DATA=`find $ddir -name "*.owl" -print`
GRAPH=http://vsto.org/graph/owl/
LOADER=${sdir}/vload
DELETER=${sdir}/vdelete

if [ "$GRAPH" = "" -o "$ONTOLOGIES" = "" ]
then
	echo "Must specify graph to load into and data directory to find rdf"
    echo "Usage: $0 <ontology_directory> <data_directory>"
	exit 1
fi

$DELETER $GRAPH
for f in $ONTOLOGIES $DATA
do
  if [ "$f" != "schema.owl" ]
  then
    echo Loading $f...
    $LOADER rdf $f $GRAPH
    sleep 1
  fi
done

