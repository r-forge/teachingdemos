petals <- function(plot=TRUE, txt=TRUE) {
    tmpstr <- "                                                                                                                                                                                                                                                                        "
tmpstr2 <- c(
             "
 O
   ","  O

O  ","O
 O
  O","O O

O O","O O
 O
O O","O O
O O
O O")
    ans <- eval(parse(text=rawToChar(packBits( unlist(strsplit(tmpstr,''))==' '))))

    resp <- TRUE
    while(resp) {
        roll <- unlist(dice(1,5,plot.it=plot))
        if(txt) {
            cat("\n---\n")
            cat(tmpstr2[roll], sep='\n---\n')
            cat("---\n")
        }
        petals <- ans(roll)
        resp <- readline('How many petals around the rose? ')
        if(nchar(resp)==0) {
            cat("There were", petals, "petals around the rose\n")
            resp <- FALSE
        } else {
            if(as.numeric(resp)==petals) {
                cat("correct, there were", petals,"petals around the rose\n", sep=' ')
            } else {
                cat("No, there were", petals, "petals around the rose\n", sep=' ')
            }
            resp <- TRUE
        }
    }
}

.onAttach <- function(...) {
    petals <- petals
    attr(petals,'source') <- "Don't Cheat!"
    assign('petals',petals,'package:TeachingDemos')
}
