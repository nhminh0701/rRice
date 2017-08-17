#' @name addDBs
#' @return The object with the new dbs
#' @rdname addDBs-methods
#' @aliases addDBs,Experiment-method
setMethod(
    "addDBs",
    signature = "Experiment",
    def = function(object){
        ## the number of databases available. To increment every time we have
        ## one more database available
        dbAvailables <- databasesAvailables()

        correctNbdb <- FALSE
        while(!correctNbdb){
            nbdb <- as.numeric(
                readline(
                    prompt="How many databases do you want to experiment ? :"))
            if(is.numeric(nbdb)){
                if (nbdb > 0 && nbdb <= dbAvailables) {
                    databases <- vector(mode='list', length=nbdb)
                    correctNbdb <- TRUE
                }
            }
            else{
                message("you have not choose a correct number of databases.")
                message("please try again")
            }
        }
        
        ##CREATE list of GenesIDs and Locuslist
        listeGenes <- object@genes
        genesIds <- list()
        listIdsByLocus <- list()
        locus <- data.frame(ch = c(), st = c(), end = c())
        
        if (length(listeGenes) > 0) {
            if (length(listeGenes[[1]]) > 0) {
                lapply(1 : length(listeGenes[[1]]),
                       function(x){
                           id <- listeGenes[[1]][[x]]@id
                           rapdb <- listeGenes[[1]][[x]]@genesIDs$RAPDB
                           msu <- listeGenes[[1]][[x]]@genesIDs$MSU7
                           
                           
                           
                           newLocus <- listeGenes[[1]][[x]]@locus

                           if (!((newLocus$ch %in% locus$ch) && 
                                 (newLocus$st %in% locus$st) && 
                                 (newLocus$end %in% locus$end))) {
                               locus <<- rbind(locus, newLocus)
                               
                               newGeneIDs <- list(rapdb, msu, id)
                               if (length(listIdsByLocus) > 0) {
                                   genesIds <<- append(genesIds, 
                                                       list(listIdsByLocus))
                               }
                               ##we init the list because we start a new locus
                               listIdsByLocus <<- list(newGeneIDs)
                           }
                           else {
                               newGeneIDs <- list(rapdb, msu, id)
                               listIdsByLocus <<- append(listIdsByLocus, 
                                                         list(newGeneIDs))
                           }
                       })
                genesIds <- append(genesIds, list(listIdsByLocus))
                #print(listIdsByLocus)
            }
        }
        else {
            stop("Be careful, in your experiment, there are no genes")
        }
        
        ##print(genesIds)
        #print(locus)

        ##INTERROGATE DBs WHICH EXISTS
        genes <- vector(mode='list', length=nbdb)
        i <- 1
        while(i <= nbdb){
            ##print the choices the user can do
            databasesList()
            ##read the choice
            databases[[i]] <- changeNumberIntoDBName(as.numeric(readline()))
            if(!alreadyUsedDB(databases,i)){
                message('loading informations of the database...')
                callDB <- paste("callDB",
                                changeDBNameIntoNumber(databases[i]),
                                sep="")
                genes[[i]] <- (do.call(callDB, args = list(genesIds, locus)))
                i <- i+1
            }
            else{
                if(alreadyUsedDB(databases,i)){
                    message("the database is already used. Try again")
                }
                else{
                    message("this number of database not exists. Try again")
                    message("You can put a number between 1 and ", dbAvailables)
                }

            }
        }
        
        ##print(genes)
        object@genes <- append(object@genes, genes)
        object@databases <- append(object@databases, databases)
        return(object)
    }
)