# title investigating COVID-19 Trends


# project is all about identifying which countries have had the highest positive cases 
#against the testing goal of the project is to identify the trends in covid-19 cases 
#across many countries. In this project the since, the provinces are of no use it has been
#removed from the dataframe. The columns are then grouped based on region and thus aggregated
#using the summerize function along with the sum function. The top ten countries who's positive
#cases are highest is made known by using the arrange function and thus stored in top_10 variable
#the ratio is then calculated ie positives/tested and top_3 countries are noted. Finally, the
#variable used are merged together in the list for the further analysis.



#readr is the package used for reading the csv files from the location
install.packages("readr")


#library readr is used to load the installed  package to an environment
library("readr")
covid_df = read_csv("C:/Users/USER/Desktop/dataquest-R/covid19.csv")


#dim is the function from readr used to check the dimensions of the csv file,here the dimensions
#Rows: 10,903 , Columns: 14
dim(covid_df)


#colnames() is used to view the column names of the dataframe that's been loaded to an enviroment
vector_cols <- colnames(covid_df)
vector_cols

#head() is  used to check the values for first 10 rows of the dataset, 10 is the default
head(covid_df)

#package tibble is used for the manipulation of the dataframe
install.packages("tibble")

#library tibble is then loaded into an environment
library("tibble")

#glimpse() is the function used to get the summary of the dataset which produces dimensions
# of the data set too
glimpse(covid_df)

#tidyverse is the package used in further manipulation of the dataset like cleaning and so on
install.packages("tidyverse")

#library tidyverse is loaded into an environment.
library("tidyverse")

#filter is used to filter out the desired values from the rows  and select() is used to 
#select the specific columns from the table
covid_df_all_states = filter(covid_df,Province_State=="All States")
covid_df <- select(covid_df,-Province_State)

#select() is used to extract the specific columns from the table and it is stored in the 
# covid_df_all_states_daily variable
covid_df_all_states_daily <- select(covid_df_all_states,c("Date","Country_Region","active","hospitalizedCurr","daily_tested","daily_positive"))
head(covid_df_all_states_daily,4)

#group_by,summarise and sum is used to get the sum of all the fields except for country_regions
covid_df_all_states_daily_sum <- covid_df_all_states_daily %>% group_by(Country_Region) %>% summarise("test"=sum(daily_tested),"positive"=sum(daily_positive),"active"=sum(active),"hospitalized"=sum(hospitalizedCurr)) %>% arrange(-test)
covid_df_all_states_daily_sum

#the head function is used to extract the top 10 rows after being manipulated
covid_top10 <- head(covid_df_all_states_daily_sum,10)
covid_top10

#top 10 country-region,test,positive,active,hospitalized is extracted from top_10 dataframe
countries <- covid_top10$Country_Region
tested_cases <- covid_top10$test
positive_cases <- covid_top10$positive
active_cases <- covid_top10$active
hospitalized_cases <- covid_top10$hospitalized

#the name() is used to assign the names for an indivisual vectors
names(tested_cases)<-countries
names(positive_cases)<-countries
names(active_cases)<-countries
names(hospitalized_cases)<-countries

#the ratio is obtained by dividing positive cases to tested cases
ratio <- positive_cases/tested_cases
ratio

#cbind() is used to bind all the vectors and create the dataframe
top_3 <- cbind(ratio,tested_cases,positive_cases,active_cases,hospitalized_cases)
top_3

#the dataframe top_3 is analysed and new vector is created which has the top 3 ratios
top_3_cases <- c("United Kingdom"=0.1132,"United States"=0.1086,"Turkey"=0.0807)
top_3_cases

#the new indivisual country vectors are created which holds the values of ratio,tested,+ves,active,hospitalized
united_kingdom <- c(0.113260617,1473672,166909,0,0)
united_states <- c(0.108618191,17282363,1877179,0,0)
turkey <- c(0.080711720 ,2031192 ,163941,2980960,0)

#rbind is used to bind the vectors row wise and create the dataframe
covid_mat <- rbind(united_kingdom,united_states,turkey)
colnames(covid_mat)<-c("ratio","tested","positive","active","hospitalized")
covid_mat

#the question and answer vector variable is created
question <- "which countries have had the highest number of positive cases against the test?"
answer <- c("positive  tested cases"=top_3_cases)
answer

#the list is used to create the dataframes,matrix and vectors which was created in this entire project
data_structure_list <- list("dataframes"=c(covid_df,covid_df_all_states,covid_df_all_states_daily,
                                           covid_top10),"matrix"=c(covid_mat),
                            "vectors"=c(countries,vector_cols))
#the dataframe is viewed
data_structure_list["dataframes"]
