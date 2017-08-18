# rRice package

This project has been made to simplify the work of biologists when they are studying the rice genome. The aim of this project is to support analysis of the rice genomics, including the downstream analysis of GWAS such as gene annotation, QTL analysis and primer design. 

## Overview

This **rRice** package will allow the biologist to :

* Create an experiment.

* Interrogate Databases. Currently, 10 databases are avaible to use :
    - RAPDB 
    - Gramene
    - Oryzabase
    - Ic4r
    - Planttfdb
    - Plntfdb
    - Funricigenes
    - Funricigenes2
    - Funricigenes3
    - Msu7
    
* Add manually new databases to your experiment in order to enrich your datas.

* Create an array with only the genes and properties wanted.

## Requirements

The installation of the **rRice** package will require few tools on your computer :
* R
* Python3 with few libraries available (pandas, requests, bs4, json, gzip and lxml)

## Installation

If you want to install **rRice** package you will have to follow the instructions below :

### 1.) Install **rRice** package in R

From R, write in the R's console the following line :
```
install.packages("rRice")
```

## Licence

The **rRice** package is licenced under the Artistic-2.0



