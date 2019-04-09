# NRLcalc: calculation of the nucleosome repeat length

Code used from the paper 'What determines the decrease in nucleosome repeat length near bound CTCF?'

# Description
Nucleosome Repeat Length (NRL) is a calculation that I have had to perform many times throughout my PhD.
This measurement serves as a metric for nucleosome packing density for a piece of chromatin.

It involves manual point/peak picking on a plot called a phasogram. 
Having done this for many different phasograms in my work on the paper 'What determines the decrease in nucleosome repeat length near bound CTCF?', I needed an easy way to go through them with relative ease and efficiency.
The applet 'NRLcalc.R' allows one to interactively click and pick points on each plot, and easily calculate the NRL value for many different phasograms by use of a 'Next' and 'Back' button. NRLcalc was made using [shiny](https://shiny.rstudio.com).

# NRLcalc.R
```
ls data/*aggregate.txt > data/files #list all files with phasogram data in 'files'

#the Rscript will read 'files' and can then the app can be run

R
install.packages('shiny')

install.packages('zoo')

install.packages('plyr')

Rscript NRLcalc.R #returns a url ID- "http://127.0.0.1:XXXX" which can be copied and pasted into your browser to use app.

###NOTE can also be run from RStudio- with the provided 'RunApp' button
```

# Data and scripts

Also I have provided exemplary scripts and data used in my paper: 'What determines the decrease in nucleosome repeat length near bound CTCF?'- See description below:

`data`
Directory contains example phasogram text files used in NRL calculations for CTCF predicted binding sites.

`scripts`
Directory contains code that went into the preparation, processing and interpretation of the data. Can all be run sequentially from 'step_by_step.sh'. Also please install all prerequisites for this code (specified in prerequisites_scripts.sh).


# Demonstration
![](https://github.com/chrisclarkson/pics/blob/master/ezgif.com-video-to-gif-2.gif)
