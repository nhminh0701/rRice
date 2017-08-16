#' @rdname getGenesIds-methods
#' @aliases getGenesIds,Experiment-method
#' @examples 
#' exp <- new(Class="Experiment",
#' name="test",
#' date=Sys.Date(),
#' databases=list(1),
#' others=list())
#' list <- getGenesIds(exp, "RAPDB")
setMethod(
    "getGenesIds",
    signature = "Experiment",
    def = function(object, typeID){
        listeGenesIds <- list()
        listeGenes <- object@genes
        
        while (typeID != "RAPDB" && typeID != "MSU") {
            print("You refer a wrong typeID")
            typeID <- as.character(
                readline(
                    prompt="Write your new typeID :"))
        }
        
        ##we verify that the liste of genes is not empty
        if (length(listeGenes) > 0 && length(listeGenes[[1]]) > 0) {
            lapply(1 : length(listeGenes[[1]]),
                   function(x){
                       if (typeID == "RAPDB") {
                           listeGenesIds <<- append(listeGenesIds, 
                                            listeGenes[[1]][[x]]@genesIDs$RAPDB)
                       }
                       else if (typeID == "MSU") {
                           listeGenesIds <<- append(listeGenesIds,
                                             listeGenes[[1]][[x]]@genesIDs$MSU7)
                       }
                   })
        }
        
        return(listeGenesIds)
    }
)




