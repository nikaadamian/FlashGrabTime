library(forestplot)
# Cochrane data from the 'rmeta'-package
meta <- 
  structure(list(
    mean  = c( NA, 1.1, 3, 3.5, NA, 2.53), 
    lower = c(NA, 0.2, 1.9, 1.5, NA, 1.2),
    upper = c( NA, 2.2, 4.2, 5.5, NA, 3.96)),
    .Names = c("mean", "lower", "upper"), 
    row.names = c(NA, -3L), 
    class = "data.frame")

tabletext<-cbind(
  c("Study", "Van Heusden et al., 2018", "Van Heusden et al., 2019", 
    "van Heusden et al. (unpublished)", NA, "Summary"),
  c("Number of participants", "8", "17", 
    "12", NA, NA),
  c("Number of trials","12859", "?", 
    "8640", NA, NA),
  c("Best-fit slope", "1.1", "3", 
    "3.5", NA, "?"))

forestplot(tabletext, 
           meta,new_page = T,
           is.summary=c(TRUE,rep(FALSE,4),TRUE),
           colgap=unit(0,'npc'),
           clip=c(-5,5.5), 
           xlog=FALSE, 
           col=fpColors(box="royalblue",line="darkblue", summary="royalblue"))
