

library(tidyverse)

## TARGET DIR
# All README files in this directory (recursively) will be updated
TARGET_DIR <- "~/Documents/Swift"

OLD_URL <- "https://www.joshdoesathing.com"
NEW_URL <- "https://joshuacook.netlify.com"

OLD_BADGE_TITLE <- "JoshDoesaThing"
NEW_BADGE_TITLE <- "Joshua_Cook"



# get README file paths
readme_files <- list.files(TARGET_DIR, recursive = TRUE, pattern = "README", full.names = TRUE)
readme_files <- readme_files[basename(readme_files) %in% c("README.txt", "README.md", "README.Rmd")]

cat("Found the following files to update:\n")
cat(readme_files, sep = "\n")

# update the badge URL and title
updateWebsiteReadmeBadges <- function(fn) {
    readme_lines <- readLines(fn)
    
    edit_website_badge <- function(old_line) {
        new_line <- str_replace(old_line, OLD_URL, NEW_URL) %>%
            str_replace(OLD_BADGE_TITLE, NEW_BADGE_TITLE)
        return(new_line)
    }
    
    new_readme_lines <- lapply(readme_lines, edit_website_badge)
    writeLines(unlist(new_readme_lines), fn)
    
}


# loop through all READMEs
for (f in readme_files) {
    updateWebsiteReadmeBadges(f)
}
