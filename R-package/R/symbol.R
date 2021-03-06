#' Create a symbolic variable with specified name.
#'
#' @param name string
#'     The name of the result symbol.
#' @return The result symbol
#' @name mx.symbol.Variable
#'
#' @export
NULL

#' Create a symbol that groups symbols together.
#'
#' @param kwarg
#'     Variable length of symbols or list of symbol.
#' @return The result symbol
#'
#' @export
mx.symbol.Group <- function(...) {
  mx.varg.symbo.internal.Group(list(...))
}

#' Save an mx.symbol object
#'
#' @param symbol the \code{mx.symbol} object
#' @param filename the filename (including the path)
#'
#' @examples
#' data = mx.symbol.Variable('data')
#' mx.symbol.save(data, 'temp.symbol')
#' data2 = mx.symbol.load('temp.symbol')
#'
#' @export
mx.symbol.save <-function(symbol, filename) {
  filename <- path.expand(filename)
  symbol$save(filename)
}

#' Load an mx.symbol object
#'
#' @param filename the filename (including the path)
#'
#' @examples
#' data = mx.symbol.Variable('data')
#' mx.symbol.save(data, 'temp.symbol')
#' data2 = mx.symbol.load('temp.symbol')
#'
#' @export
mx.symbol.load <-function(filename) {
  filename <- path.expand(filename)
  mx.symbol.load(filename)
}

#' Inference the shape of arguments, outputs, and auxiliary states.
#'
#' @param symbol The \code{mx.symbol} object
#'
#' @export
mx.symbol.infer.shape <- function(symbol, ...) {
  symbol$infer.shape(list(...))
}

is.MXSymbol <- function(x) {
  inherits(x, "Rcpp_MXSymbol")
}

#' Judge if an object is mx.symbol
#'
#' @return Logical indicator
#'
#' @export
is.mx.symbol <- is.MXSymbol


#' Get the arguments of symbol.
#' @param x The input symbol
#'
#' @export
arguments <- function(x) {
  if (!is.MXSymbol(x))
    stop("only for MXSymbol type")
  x$arguments
}

#' Apply symbol to the inputs.
#' @param x The symbol to be applied
#' @param kwargs The keyword arguments to the symbol
#'
#' @export
mx.apply <- function(x, ...) {
  if (!is.MXSymbol(x)) stop("only for MXSymbol type")
  x$apply(list(...))
}

#' Get the outputs of a symbol.
#' @param x The input symbol
#'
#' @export
outputs <- function(x) {
  if (!is.MXSymbol(x)) stop("only for MXSymbol type")
  x$outputs
}

init.symbol.methods <- function() {
  # Think of what is the best naming
  setMethod("+", signature(e1 = "Rcpp_MXSymbol", e2 = "Rcpp_MXSymbol"), function(e1, e2) {
    mx.varg.symbol.internal.Plus(list(e1, e2))
  })
  setMethod("-", signature(e1 = "Rcpp_MXSymbol", e2 = "Rcpp_MXSymbol"), function(e1, e2) {
    mx.varg.symbol.internal.Minus(list(e1, e2))
  })
  setMethod("*", signature(e1 = "Rcpp_MXSymbol", e2 = "Rcpp_MXSymbol"), function(e1, e2) {
    mx.varg.symbol.internal.Mul(list(e1, e2))
  })
  setMethod("/", signature(e1 = "Rcpp_MXSymbol", e2 = "Rcpp_MXSymbol"), function(e1, e2) {
    mx.varg.symbol.internal.Div(list(e1, e2))
  })

}
