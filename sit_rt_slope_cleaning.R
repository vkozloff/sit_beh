#  SIT RT Slope Cleaning
#  Violet Kozloff
#  April 8th 2018 
#  This script cleans the auditory and visual files from the 4-run pilot for reaction time slope analysis
#  ****************************************************************************

# Prepare files ------------------------------------------------------------

# Move to folder from GitHub (Mac when folder is on desktop)
setwd("/Users/qlab_macbook/Documents/sit_analysis_start/")

# Remove objects in environment
rm(list=ls())

# Set up file paths
ll_path <- ("/Users/qlab_macbook/Documents/sit_data/original/ll/")
lv_path <- ("/Users/qlab_macbook/Documents/sit_data/original/lv/")
vl_path <- ("/Users/qlab_macbook/Documents/sit_data/original/vl/")
vv_path <- ("/Users/qlab_macbook/Documents/sit_data/original/vv/")
output_path <- ("/Users/qlab_macbook/Documents/sit_data/clean/")
ll_files<- list.files(path=ll_path, pattern="*.csv")
lv_files<- list.files(path=lv_path, pattern="*.csv")
vl_files<- list.files(path=vl_path, pattern="*.csv")
vv_files<- list.files(path=vv_path, pattern="*.csv")

# Clean files with an lsl test phase --------------------------------------------------------------------------------

# create a new file containing only the relevant columns in the output folder
lsl_clean <- function(file) {
  current_file <- read.csv(file)
  # Select relevant columns
  value <- c("PartID", "expName", "condition", "image","l_block_trial_key_resp.rt","lsl_question_key_resp.corr")
  newdata <- current_file[value]
  # Put all data in lowercase
  names(newdata) <- tolower(names(newdata))
  # Standardize "corr_resp" column across runs
  names(newdata)[names(newdata) == 'lsl_question_key_resp.corr'] <- 'corr_resp'
  # Standardize "react_time" across runs
  names(newdata)[names(newdata) == 'l_block_trial_key_resp.rt'] <- 'react_time'
  # Separate words by underscore
  names(newdata) <- gsub ("partid", "part_id", names(newdata))
  names(newdata) <- gsub ("expname", "exp_name", names(newdata))
  # Write file
  this_path<-file.path(output_path, basename(file))
  write.csv(newdata, file=(this_path))
}

# Apply function to all ll files
for (file in ll_files)
{
  lsl_clean(paste0(ll_path,file))
}

# Apply function to all lv files
for (file in lv_files)
{
  lsl_clean(paste0(lv_path,file))
}


# Clean files with an lsl test phase --------------------------------------------------------------------------------

# create a new file containing only the relevant columns in the output folder
vsl_clean <- function(file) {
  current_file <- read.csv(file)
  # Select relevant columns
  value <- c("PartID", "expName", "condition", "image","v_block_trial_key_resp.rt","vsl_question_key_resp.corr")
  newdata <- current_file[value]
  # Put all data in lowercase
  newdata <- tolower(newdata)
  # Standardize "corr_resp" column across runs
  names(newdata)[names(newdata) == 'vsl_question_key_resp.corr'] <- 'corr_resp'
  # Standardize "react_time" across runs
  names(newdata)[names(newdata) == 'v_block_trial_key_resp.rt'] <- 'react_time'
  # Separate words by underscore
  names(newdata) <- gsub ("partid", "part_id", names(newdata))
  names(newdata) <- gsub ("expname", "exp_name", names(newdata))
  # Write file
  this_path<-file.path(output_path, basename(file))
  write.csv(newdata, file=(this_path))
}

# Apply function to all vl files
for (file in vl_files)
{
  vsl_clean(paste0(vl_path,file))
}

# Apply function to all vv files
for (file in vv_files)
{
  vsl_clean(paste0(vv_path,file))
}



#TO DO: FOR ACCURACY: # Remove any lines prior to test phase
#newdata <- newdata[ which(!is.na(newdata$key_resp.corr)), ]
# TO DO: Add modality (ling/ non-ling)
# TO DO: include modern equivalent of "ltarget", "vtarget"
# TO DO: Currently excludes sit_a_010_vv, which is missing the rt column?