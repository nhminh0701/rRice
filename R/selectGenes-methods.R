#' @return The object with the new db
#' @rdname selectGenes-methods
#' @aliases selectGenes,Experiment-method
#' @examples 
#' exp <- new(Class="Experiment",
#' name="test",
#' date=Sys.Date(),
#' databases=list(1),
#' others=list())
#' listGenesIds <- list()
#' exp <- selectGenes(exp, listGenesIds, "RAPDB")
setMethod(
    "selectGenes",
    signature = "Experiment",
    def = function(object, liste, typeID){
        while (typeID != "RAPDB" && typeID != "MSU") {
            print("You refer a wrong typeID")
            typeID <- as.character(
                readline(
                    prompt="Write your new typeID :"))
        }
        
        nbDataBases <- object@databases
        listeGenes <- object@genes
        nbRemove <- 0
        
        if (length(liste) > 0) {
            
            if (length(listeGenes) > 0 && length(listeGenes[[1]]) > 0) {
                if (typeID == "RAPDB") {
                    lapply(1 : length(listeGenes[[1]]),
                           function(x){
                               rapdb <- object@genes[[1]][[x]]@genesIDs$RAPDB
                               if (!(rapdb %in% liste)) {
                                   #print("in")
                                   #print(rapdb)
                                   lapply(1 : length(listeGenes),
                                       function(y){
                                          listeGenes[[y]][[x-nbRemove]] <<- NULL
                                       })
                                   nbRemove <<- nbRemove+1
                                   #print(paste("remove ",nbRemove))
                               }
                           })
                }
                else if (typeID == "MSU") {
                    lapply(1 : length(listeGenes[[1]]),
                           function(x){
                               msu <- object@genes[[1]][[x]]@genesIDs$MSU7
                               if (!(msu %in% liste)) {
                                   #print("in")
                                   #print(msu)
                                   lapply(1 : length(listeGenes),
                                       function(y){
                                          listeGenes[[y]][[x-nbRemove]] <<- NULL
                                       })
                                   nbRemove <<- nbRemove+1
                                   #print(paste("remove ",nbRemove))
                               }
                           })
                }
            }
        }
        else {
            stop("You provide an empty list")
        }
        object@genes <- listeGenes
        #print(listeGenes)
        return(object)
    }
)