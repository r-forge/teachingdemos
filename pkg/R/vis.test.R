vis.test <- function(..., FUN, data.name='', alternative) {
    dots <- list(...)
    if(missing(FUN)) {
        m <- sapply( dots, mode )
        mm <- m == 'function'
        if(any(mm)){
            mm <- min(which(mm))
        } else {
            stop('A function to create the plot must be specified')
        }
        FUN <- dots[[mm]]
        dots[[mm]] <- NULL
    }

    seeds <- sample(1024, 20)
    seeds <- list( sample( c(NA, seeds[1:8] ) ),
                   sample( c(NA, seeds[1:2], seeds[9:14] ) ),
                   sample( c(NA, seeds[1:2], seeds[15:20] ) ) )

    sel <- integer(3)
    dev.new()
    par(mfrow=c(3,3))
    for(i in 1:3) {
        for( j in seeds[[i]] ) {
            if (is.na(j)) {
                dots$orig <- TRUE
                do.call(FUN, dots)
            } else {
                set.seed(j)
                dots$orig <- FALSE
                do.call(FUN, dots)
            }
        }

        loc <- locator(1)
        csel <- 1
        x <- grconvertX(loc$x, from='user', to='ndc')
        if( x > 1/3 ) csel <- csel + 1
        if( x > 2/3 ) csel <- csel + 1
        y <- 1-grconvertY(loc$y, from='user', to='ndc')
        if( y > 1/3 ) csel <- csel + 3
        if( y > 2/3 ) csel <- csel + 3

        sel[i] <- csel

    }

    cnt <- sum( sapply( 1:3, function(i) is.na(seeds[[i]][ sel[i] ]) ) )
    names(cnt) <- 'Number Correct'
    p.value <- pbinom( 3-cnt, 3, 8/9 )

    out <- list( method='Visual Test', data.name=data.name,
                 statistic=cnt, p.value=p.value)
    if( !missing(alternative) ) out$alternative <- alternative

    out$seeds <- seeds
    out$selected <- sel

    dev.off()

    class(out) <- 'htest'
    return(out)
}

vt.qqnorm <- function(x, orig=TRUE) {
    par(mar=c(2.5,2.5,1,1)+0.1)
    if(orig) {
        qqnorm(x,xlab='',ylab='',main='')
        qqline(x)
    } else {
        y <- rnorm( length(x), mean(x), sd(x) )
        qqnorm(y,xlab='',ylab='',main='')
        qqline(y)
    }
}

vt.normhist <- function(x, ..., orig=TRUE) {
    par(mar=c(2.5,2.5,1,1)+0.1)
    if(orig) {
        hist(x, main='', xlab='', ylab='', prob=TRUE, ...)
        curve(dnorm(x, mean(x), sd(x)), add=TRUE, col='blue')
    } else {
        y <- rnorm( length(x), mean(x), sd(x) )
        hist(y, main='', xlab='', ylab='', prob=TRUE, ...)
        curve(dnorm(x, mean(y), sd(y)), add=TRUE, col='blue')
    }
}

vt.scatterpermute <- function(x, y, ..., orig=TRUE) {
    par(mar=c(2.5,2.5,1,1)+0.1)
    if(orig) {
        plot(x, y, xlab='', ylab='', ...)
    } else {
        plot(x, sample(y), xlab='', ylab='', ...)
    }
}

vt.tspermute <- function(x, type='l', ..., orig=TRUE) {
    par(mar=c(2.5,2.5,1,1)+0.1)
    if(orig) {
        plot(x, type=type, xlab='', ylab='', ...)
    } else {
        plot(sample(x), type=type, xlab='', ylab='', ...)
    }
}

vt.residpermute <- function(model, ..., orig=TRUE) {
    par(mar=c(2.5,2.5,1,1)+0.1)
    if(orig) {
        scatter.smooth( fitted(model), resid(model), xlab='', ylab='',
                        col='blue' )
        abline(h=0, col='green')
    } else {
        scatter.smooth( fitted(model), sample(resid(model)),
                        xlab='', ylab='', col='blue')
        abline(h=0, col='green')
    }
}


