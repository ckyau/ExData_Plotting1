installLoadPackages <- function(pkgVec, folderToInstallTo = .libPaths()[1]) {
  .libPaths( c( folderToInstallTo , .libPaths() ) )
  new.pkg <- pkgVec[!(pkgVec %in% installed.packages()[, "Package"])]
  if (length(new.pkg) > 0) {install.packages(new.pkg, dependencies = TRUE)}
  sapply(pkgVec, require, character.only = TRUE)
}

