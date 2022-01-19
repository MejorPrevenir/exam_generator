#install.packages("exams")
#tinytex::install_tinytex()
library("exams")

setwd("exercises")

# First session
exams_skeleton(markup = "markdown", encoding = "UTF-8",
               writer = c("exams2html", "exams2pdf", "exams2moodle"))


# Written Multiple-Choice Exams

# Select list of exercises in Latex or Rmarkdown format
myexam <- list(
  "tstat2.Rnw",
  "ttest.Rnw",
  "relfreq.Rnw",
  "anova.Rnw",
  c("boxplots.Rnw", "scatterplot.Rnw"),
  "cholesky.Rnw"
)

set.seed(403)

# Demo exam with 2 randomly-drawn versions
ex1 <- exams2nops(myexam, n = 2,
                  dir = "nops_pdf", name = "demo", date = "2015-07-29",
                  points = c(1, 1, 1, 2, 2, 3), showpoints = TRUE)

# For non-duplex printing, set "duplex=FALSE"

# Example of two completed demo sheets
img <- dir(system.file("nops", package = "exams"), pattern = "nops_scan",
           full.names = TRUE)
dir.create("nops_scan")
file.copy(img, to = "nops_scan")

# Read all scanned images

nops_scan(dir = "nops_scan")
dir("nops_scan")

# Error: no me genera el archivo ZIP, falta instalar Rtools
?nops_scan



# Evaluate results

# Create demo CSV file with student information
write.table(data.frame(
  registration = c("1501090", "9901071"),
  name = c("Jane Doe", "Ambi Dexter"),
  id = c("jane_doe", "ambi_dexter")
), file = "Exam-2015-07-29.csv", sep = ";", quote = FALSE, row.names = FALSE)

# Evaluate answers and create html reports

ev1 <- nops_eval(
  register = "Exam-2015-07-29.csv",
  solutions = "nops_pdf/demo.rds",
  scans = Sys.glob("nops_scan/nops_scan_*.zip"),
  eval = exams_eval(partial = FALSE, negative = FALSE),
  interactive = FALSE
)
dir()



# Example dynamic numbers exam
library("exams")
exams2pdf("elasticity1.Rmd")
exams2pdf("elasticity2.Rmd")
exams2pdf("elasticity3.Rmd")
exams_metainfo(exams2html("elasticity3.Rmd"))

# To check for "extreme" solutions
rm(list = ls())
s <- stresstest_exercise("elasticity3.Rmd", n = 200)
plot(s)
plot(s, type = "solution")

exams2pdf("elasticity4.Rmd")
exams2pdf("elasticity5.Rmd")


# Example in English, then Spanish
myexam <- c("deriv2.Rnw", "tstat2.Rnw", "swisscapital.Rnw")
set.seed(403)
exams2nops(myexam, n = 1, language = "en",
           institution = "R University", title = "Exam",
           dir = "nops_pdf", name = "en", date = "2018-01-08")
set.seed(403)
exams2nops(myexam, n = 1, language = "es",
           institution = "R Universidad", title = "Examen",
           dir = "nops_pdf", name = "es", date = "2018-01-08")