#----install-packages----
if(!require("pacman"))install.packages("pacman")
pacman::p_load("fs", "usethis", "here")

#----create-project----
proj_name <- readline(prompt = "Enter project name:")

dir_create(proj_name)
setwd(proj_name)
file_copy("../setr.r", path_wd())
create_project(path_wd(), rstudio = TRUE, open = TRUE)

#----setup-project----
# options
name <- "Aaron Peikert"
mail <- "aaron.peikert@posteo.de"

token <- github_token()
if(token==""){
  browse_github_token()
  token <- readline("Github-Token:")
}
options(usethis.full_name = name)

# blank
use_blank_slate("project")

# readme
use_readme_md()

# license
use_template("license-mit.txt", save_as = "LICENSE", data = usethis:::license_data(name))
use_badge("License: MIT", "https://opensource.org/licenses/MIT", "https://img.shields.io/badge/License-MIT-yellow.svg")

# code of conduct
use_code_of_conduct()

# git
use_git_ignore(c("*.html", "*.pdf", "supplement/", "data/", "setr.r"))
use_git_config(user.name = name, user.email = mail)
use_git("initial")
use_github(auth_token = token)
