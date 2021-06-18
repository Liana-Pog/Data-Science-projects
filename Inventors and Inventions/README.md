### The project can be found in the [link.](https://lianapoghosyan13.shinyapps.io/Group_Homework/)


# Introduction to the Project

The goal of this project is to use Web scraping and API approaches to scrap text data and do text mining on it by the help of techniques and skilled gained during our course. Our group has also produced a ShinyApp data product for the project.

The tasks in this project are

* Get a reasonable Data using Web scraping techniques
* Do text Mining and Data Cleaning on the data
* Perform exploratory analysis on dataset

The **topic of the project** is **Inventors and their Inventions**. The text data about different inventors' *Names, Born year, Death Year, Country* and *Inventions* are scrapped from Wikipedia\
(https://en.wikipedia.org/wiki/List_of_inventors).


The ShinyApp uses analysis done in the project. You can find it in the link below:\
https://anijeyranyan.shinyapps.io/Group_Homework/

\newpage

## Main hypotheses

* What are the countries having the highest number of inventors.
* What are the relationship of Age and number of inventors in top-3 countries that had the superiority in the number of inventors.
* What are the countries having the highest number of inventions.
* What is the percentage of inventors in different categories of the life duration. 
* Which century had the highest number of of the inventors born.
* What is the density of different number of inventions(categorized).
* What is the relationship between average number of inventions and the lifespan of inventors.
* What is the relationship between Age and Number of inventions(1-2 inventions).


# Data Cleaning and Exploring

**The following mining and cleaning steps are performed on the scrapped text data to get a dataset:**

* There have been inventors in the list whose death names aren't known, and the  format of their Born year were different from general format (e.g. born 1638). We have extracted the word born from the Date to get only the numeric value in the future,
* There have been inventions which have been done as a result of by more than one inventor's work. Usually in such cases the co-inventors have been mentioned after expression *together with* and information about them is ended with comma. So We have separated co-workers as well and demonstrated them as a separate inventor with the same invention,
* The Born Dates and Death dates have been separated,
* The country of the inventor has been separated from the invention description,
* Checks and cleaning have been done for full and partial duplicates in the gained dataset,
* Rows with unknown inventors(Name is NA) have been cleaned.
