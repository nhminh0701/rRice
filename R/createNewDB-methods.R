#' @return The object with the new db
#' @rdname createNewDB-methods
#' @aliases createNewDB,Experiment-method
setMethod(
    "createNewDB",
    signature = "Experiment",
    def = function(object){
        ##GET INFORMATIONS ABOUT THE NEW DB
        cat(paste0("Your file has to be built as follow : ",
                   "\r\nFirst line is composed with all the names of the",
                   " attributes",
                   "\r\nOthers lines composed with all the values of the",
                   " genes\n"))
        
        ##Ask the name of the new DB
        name <- as.character(
            readline(
                prompt="Write the name of your new db :"))

        ##Reference the typeID
        typeID <- as.numeric(
            readline(
                prompt=paste("What kind of typeID is on the first",
                "row of your file (1 : msu; 2 : rapdb) : ")))
        
        while (typeID >2 || typeID <1) {
            print("You have to seize 1 or 2")
            typeID <- as.numeric(
                readline(
                    prompt=paste("What kind of typeID is on the first",
                                 "row of your file (1 : msu; 2 : rapdb) : ")))
        }

        ##Ask the kind of separator
        separator <- as.character(
            readline(
                prompt="Which separator is used in your file ? :"))

        ##Ask the absolute path for the file
        File <- as.character(
            readline(
                prompt="Write the absolute path until your file :"))

        ##verify if the file exists
        while (!file.exists(File)) {
            print("Your file doesn't exist")
            File <- as.character(
                readline(
                    prompt="Write the absolute path until your file :"))
        }
        
        # name <- "test"
        # typeID <- 2
        # separator <- ","
        # File <- "/home/eisti/ING1/Voyage_VIETNAM/PROJET/file2.txt"
        
        object@databases <- append(object@databases, name)
        
        # name <- "test"
        # typeID <- 1
        # separator <- ","
        # File <- "/home/eisti/ING1/Voyage_VIETNAM/PROJET/file1.txt"
        
        
        
        tab <- read.table(File, sep = separator, header = TRUE)
        
        
        
        
        
        ##EXTRACT all the file in a well-made list
        l <- list()
        liste <- list()
        lapply(1 : dim(tab)[1],
               function(x){
                   l <- list()
                   lapply(1 : dim(tab)[2],
                          function(y){
                              l <<- append(l,list(tab[x,y]))
                          })
                   ##print(l)
                   liste <<- append(liste,list(l))
               })
        
        attributes <- names(tab)
        #print(attributes[2])
        #print(length(attributes))
        #print(class(attributes))
        ##print(liste)
        
        ##We get the liste of genes in order to be able to match the genes with 
        ##the new list of genes
        genes <- getGenes(object)
        ##print(genes)
        
        listeGenes <- lapply(1 : length(genes[[1]]),
                        function(x) matchGenes(genes[[1]][[x]],
                                               typeID,
                                               liste,
                                               attributes))
        
        #print(listeGenes)
        
        ##Add listeGenes to the object's genes
        object@genes <- append(object@genes, list(listeGenes))
        
        return(object)
    }
)

#' matchGenes
#'
#' Return the genes of the list which matches the gene
#'
#' @param gene Gene
#' @param typeID id is msu(1) or rapdb(2)
#' @param newListGenes list of genes
#' @param newAttributes list of the attributes
#' @return it will return a gene
#' @importFrom methods new
#' @rdname matchGenes-function
matchGenes <- function  (gene, typeID, newListGenes, newAttributes) {
    #print(gene)
    id <- gene@genesIDs[typeID]
    listeAttr <- list()
    #print(id)
    #print(gene)
    #print(newListGenes)
    #print(length(newAttributes))
    ##Check for the match 
    #listeAttr <- list()
    lapply(1 : length(newListGenes),
           function(x){
               if (id == newListGenes[[x]][[1]]) {
                   if (length(newAttributes) > 1) {
                       lapply(2 : length(newListGenes[[x]]),
                              function(y){
                                 listeAttr <<- append(listeAttr,
                                               as.character(
                                                   newListGenes[[x]][[y]]))
                                 size <- length(listeAttr)
                                 names(listeAttr[[size]]) <<- newAttributes[[y]]
                                 }
                              )
                   }
                   #print(listeAttr)
                   # else {
                   #     listeAttr <- list()
                   # }
               }
           })
    
    #print(listeAttr)
    #print(id$RAPDB)
    
    if (typeID == 1) {
        genesids <- list(MSU7 = id$MSU7,
                         RAPDB = "")
    }
    else {
        genesids <- list(MSU7 = "",
                         RAPDB = id$RAPDB)
    }
    
        
    if (length(listeAttr)>0) {
        newGene <- new("Gene",
                       id = "",
                       genesIDs = genesids,
                       locus = data.frame(),
                       others = listeAttr)
        
                       return(newGene)
    }
    else {
        newGene <- new("Gene",
                       id = "",
                       genesIDs = genesids,
                       locus = data.frame(),
                       others = list())
        
        return(newGene)
    }
}