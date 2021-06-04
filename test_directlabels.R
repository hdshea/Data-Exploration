

library(tidyverse)
library(directlabels)

data(BodyWeight,package="nlme")
p <- qplot(Time,weight,data=BodyWeight,colour=Rat,geom="line",facets=.~Diet)
direct.label(p,"first.qp")
direct.label(p,"last.qp")
