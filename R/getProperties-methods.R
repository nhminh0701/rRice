#' @rdname getProperties-methods
#' @aliases getProperties,Experiment-method
#' @import purrr
setMethod(
    "getProperties",
    signature = "Experiment",
    definition = function(object, idWanted){
        geneList <- object@genes
        attributesList <- object@properties
        if(length(geneList) == 0){
            stop("your gene list is empty")
        }
        if(!inherits(geneList[[1]][[1]],c("Gene"))){
            stop("you are not giving a list of genes")
        }
        if(idWanted != "RAPDB" && idWanted != "MSU7"){
            stop("you have to give RAPDB or MSU7 as idWanted parameter")
        }
        if(length(attributesList) == 0){
            return(object@genes)
        }else{
            ##get the Ids that the user want as name
            geneNames <- purrr::map(geneList[[1]], function(x){
                x@genesIDs[idWanted][[1]]
            })
            ##declare the matrix with the size we need
            result <- matrix(nrow=length(geneList[[1]]),
                             ncol=length(attributesList))
            ##change the matrix in a dataframe
            result <- as.data.frame(result)
            ##give the name to every gene which is now a line of the dataframe
            row.names(result) <- geneNames
            i <- 1
            j <- 1
            while(j <= length(geneList[[1]])){
                while (i <= length(geneList)){
                    for(k in 1:length(attributesList)){
                        obj <- strsplit(attributesList[[k]],"[.]")
                        className <- obj[[1]][[1]]
                        attributeName <- obj[[1]][[2]]
                        if(class(geneList[[i]][[j]]) == className && class(geneList[[i]][[j]]) != "Gene"){
                            properties <- attributes(geneList[[i]][[j]])
                            properties <- properties[attributeName]
                            properties <- properties[[1]]
                            if(typeof(properties) == "list"){
                                for(i in 1:length(properties)){
                                result[[k]][[j]] <- paste(result[[k]][[j]],
                                                          properties[[i]])
                                }
                            }else{
                                result[[k]][[j]] <- properties[[1]]
                            }
                        }
                        else if (class(geneList[[i]][[j]]) == "Gene") {
                            properties <- attributes(geneList[[i]][[j]])
                            properties <- properties["others"]
                            properties <- properties[[1]]
                            #print(properties)
                            #print(length(properties))
                            #print(names(properties[[1]]))
                            if (length(properties) > 0) {
                                for (w in 1 : length(properties)) {
                                    #print(properties)
                                    if(names(properties[[w]]) == attributeName){
                                        #print(names(properties[[w]]))
                                        #print(class(properties[[w]]))
                                        propertiesFinal <- properties[[w]]
                                        #print(propertiesFinal)
                                        #print(w)
                                    }
                                }
                            }
                            #properties <- properties[[1]]
                            if(typeof(propertiesFinal) == "list"){
                                for(i in 1:length(propertiesFinal)){
                                    result[[k]][[j]] <- paste(result[[k]][[j]],
                                                        propertiesFinal[[i]])
                                }
                            }else{
                                result[[k]][[j]] <- propertiesFinal[[1]]
                            }
                        }
                    }
                    i <- i+1
                }
                j <- j+1
                i <- 1
            }
            names(result) <- tolower(attributesList)
            return(result)
        }
        
         
    }
)