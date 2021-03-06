#' Title
#'
#' @param formula a formula specifying the model
#' @param df dataset containing the variables of interest
#' @param tolerance tolerance level
#' @param maxit maximun number of iteration
#' @param verbose should the function write messages during the computation?
#'
#' @return
#' @export

lm_SD_optimizer<-function(formula, df, tolerance, maxit, verbose) {
 
  data=data_xy(formula, df)
  y=as.matrix(data$Y)
  x=as.matrix(data$X)
  
  beta = rnorm(ncol(x))
  
  err=1
  t = 1
  if(verbose){
    while( ( (err>tolerance) & (t<=maxit) ) ){
      beta_old = beta
      gr = 2*t(x)%*%(x%*%beta-y)
      hess = 2*t(x)%*%x
      step = as.numeric( sum(gr^2)/( t(gr)%*%hess%*%gr ) )
      beta = beta - step*gr 
      err = max(abs(beta-beta_old))
      print(paste("error at iteration", t, ":", err))
      t = t+1
    }
  }
  else{
    while( ( (err>tolerance) & (t<=maxit) ) ){
      beta_old = beta
      gr = 2*t(x)%*%(x%*%beta-y)
      hess = 2*t(x)%*%x
      step = as.numeric( sum(gr^2)/( t(gr)%*%hess%*%gr ) )
      beta = beta - step*gr 
      err = max(abs(beta-beta_old))
      t = t+1
    }
  }
  output = list(beta_hat=beta, Y=data$Y, X=data$X, model_formula=formula, method="Steepest Descend")
  return(output)
}
