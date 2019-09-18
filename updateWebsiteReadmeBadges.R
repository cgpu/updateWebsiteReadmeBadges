

library(tidyverse)

## TARGET DIR
# All README files in this directory (recursively) will be updated
TARGET_DIR <- "~/Documents/R"

OLD_URL <- "https://twitter.com/JoshDoesa"
NEW_URL <- "https://twitter.com/JoshDoesa"

OLD_BADGE_TITLE <- "Website-JoshDoesaThing"
NEW_BADGE_TITLE <- "Twitter-@JoshDoesA"

# additional specifications (optional)
BADGE_LOGO <- "telegram"


# get README file paths
readme_files <- list.files(TARGET_DIR, recursive = TRUE, pattern = "README", full.names = TRUE)
readme_files <- readme_files[basename(readme_files) %in% c("README.txt", "README.md", "README.Rmd")]

cat("Found the following files to update:\n")
cat(readme_files, sep = "\n")



# update the badge URL and title
updateWebsiteReadmeBadges <- function(fn) {
    readme_lines <- readLines(fn)
    
    edit_website_badge <- function(old_line) {
        if (str_detect(old_line, paste0("logo=", str_to_lower(BADGE_LOGO)))) {
            cat("file:", fn, "\n")
            cat("--> OLD\n", old_line, "\n", sep = "")
            new_line <- str_replace(old_line, OLD_URL, NEW_URL) %>%
                str_replace(OLD_BADGE_TITLE, NEW_BADGE_TITLE)
            cat("NEW -->\n", new_line, "\n\n", sep = "")
            return(new_line)
        } else {
            return(old_line)
        }
    }
    
    new_readme_lines <- lapply(readme_lines, edit_website_badge)
    a <- try(writeLines(unlist(new_readme_lines), fn))
    if (class(a) == "try-error") {
        warning(paste("unable to write to", fn))
    }
    
}


# loop through all READMEs
for (f in readme_files) {
    updateWebsiteReadmeBadges(f)
}

