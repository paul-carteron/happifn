## Re Submit 

Considering last CRAN comment : 

- '`\dontrun{}` should only be used if the example really cannot be executed, Please replace `\dontrun` with `\donttest`' : I keep `\dontrun{}` because call to API is quite long due to big datasets request.

- 'Please do not modifiy the .GlobalEnv. This is not allowed by the CRAN
policies.' : I don't, i have argument `unlist` in my functions that use `list2env`
if `TRUE`.

Result can be found (here)[https://github.com/paul-carteron/happifn/actions/runs/10970808572]

## R CMD check results

`happifn` sucessfully pass R-CMD-Check test from rhub::rhub_chek()

macos (R-devel) doesn't work because of `archive` package, not `happifn`.

Result can be found (here)[https://github.com/paul-carteron/happifn/actions/runs/10706915094]
