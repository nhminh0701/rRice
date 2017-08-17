# rRice
=======

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
    - Msu
    
* Add manually new databases to your experiment in order to enrich your datas.

* Create an array with only the genes and properties wanted.

## Installation

If you want to install **rRice** package you will have to follow the instructions below :

### 1.) Install R

For Ubuntu, write the following line into your terminal
```
sudo apt-get update
sudo apt-get install r-base
```

### 2.) Install Rstudio

You will have to install Rsutio at the following adress : https://www.rstudio.com/products/rstudio/download/

Then you will write in your terminal the following line to execute the .deb : 
```
sudo dpkg -i DEB_PACKAGE
```

### 3.) Install **rRice** package in Rstudio

From Rstudio, write in the Rstudio's console the following line :
```
install.packages("rRice")
```

## Licence

The **rRice** package is licenced under the Artistic-2.0



