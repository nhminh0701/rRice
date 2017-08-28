# rRice package

[//]: <> <img src="https://ci.appveyor.com/api/projects/status/32r7s2skrgm9ubva?svg=true" alt="Project Badge" width="100">

This project has been made to simplify the work of biologists when they are studying the rice genome. The aim of this project is to support analysis of the rice genomics, including the downstream analysis of GWAS such as gene annotation, QTL analysis and primer design. 

## Overview

This **rRice** package will allow the biologist to :

* Create an experiment.

* Interrogate Databases. Currently, 10 databases are avaible to use :
    - RAPDB (http://rapdb.dna.affrc.go.jp/)
    - Gramene (http://www.gramene.org/)
    - Oryzabase (https://shigen.nig.ac.jp/rice/oryzabase/)
    - IC4R (http://ic4r.org/)
    - PlantTFDB (http://planttfdb.cbi.pku.edu.cn/)
    - PlnTFDB (http://plntfdb.bio.uni-potsdam.de/)
    - Funricegenes (https://funricegenes.github.io/docs/)
    - Funricegenes2
    - Funricegenes3
    - MSU7 (http://rice.plantbiology.msu.edu/)
    
* Add manually new databases to your experiment in order to enrich your datas.

* Create an array with only the genes and properties wanted.

## Requirements

The installation of the **rRice** package will require few tools on your computer :
* R
* Python3 with few libraries available (`pandas`, `requests`, `bs4`, `json`, `gzip` and `lxml`)

## Installation

If you want to install **rRice** package you will have to follow the instructions below :

To install **rRice** package, start R and enter write the following lines : 
```
source("https://bioconductor.org/biocLite.R")
biocLite("rRice")
```

## Licence

The **rRice** package is licenced under the Artistic-2.0



