\name{SnowsCorrectlySizedButOtherwiseUselessTestOfAnything}
\alias{SnowsCorrectlySizedButOtherwiseUselessTestOfAnything}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
SnowsCorrectlySizedButOtherwiseUselessTestOfAnything(x, data.name = deparse(substitute(x)), alternative = "You Are Lucky", ..., seed)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{data.name}{
%%     ~~Describe \code{data.name} here~~
}
  \item{alternative}{
%%     ~~Describe \code{alternative} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
  \item{seed}{
%%     ~~Describe \code{seed} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(x,
            data.name=deparse(substitute(x)), alternative='You Are Lucky',
                                                                 ...,
                                                                 seed) {
    if( !missing(seed) ) {
        if( is.numeric(seed) ) {
            set.seed(seed)
        } else {
            char2seed(seed)
        }
    }

    tmp.p <- runif(1)

    out <- list(
                p.value = tmp.p,
                data.name=data.name,
                method = "Snow's Correctly Sized But Otherwise Useless Test of Anything",
                alternative=alternative)
    if( !missing(seed) ) out$seed <- seed
    names(tmp.p) <- 'Random Uniform Value'
    out$statistic <- tmp.p

    class(out) <- 'htest'
    return(out)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
