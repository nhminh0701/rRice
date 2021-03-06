% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/getGenesIds-methods.R
\docType{methods}
\name{getGenesIds}
\alias{getGenesIds}
\alias{getGenesIds,Experiment-method}
\title{Get a list of ids (RAPDB or MSU)}
\usage{
getGenesIds(object, typeID)

\S4method{getGenesIds}{Experiment}(object, typeID)
}
\arguments{
\item{object}{The object for which we want modification.}

\item{typeID}{the id we want in the list (RAPDB or MSU)}
}
\value{
the list of the ids composed only with RAPDB ids or MSU ids.
}
\description{
Get a list of ids (RAPDB or MSU)
}
\examples{
exp <- new(Class="Experiment",
name="test",
date=Sys.Date(),
databases=list(1),
others=list())
list <- getGenesIds(exp, "RAPDB")
}
