# Olympic-dataset
120 years of Olympic history: athletes and results basic bio data on athletes and medal results from Athens 1896 to Rio 2016.

# Data
You can download the dataset from here. Or, you can download it by clicking on the below download button “Download Olympics Dataset”. https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results/download

# Approach data cleaning
Once you download, you would see two csv files “athlete_events.csv“ and “noc_regions.csv“.
cleaned data from “athlete_events.csv“ by using 'Power Query' in Excel and
Removed "NA" values from column Medals“athlete_events.csv“ for simplicity
Named clean data "olympics_event" and write query using this table and "noc_region" table.

# Loading dataset to SQL Database:
There are two method we can upload the data 1) from table wizard 2) from cmd prompt
Here I have used cmd prompt to upload the data, because the data set was huge it would take more than an hour if we would have imported data from "import table wizard"
