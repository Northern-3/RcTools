# Report Card Scoring

## Introduction

A key component of the Northern Three Report Cards is calculating scores
and grades for a range of indicators. To streamline this process three
key functions have been developed that work in conjuction with each
other:

1.  value_to_score()
2.  score_to_grade()
3.  save_n3_table()

Additional helper functions have been written that support these three
key functions, which include:

- bind_letter_to_score()
- define_colour_scheme()
- conditional_formatter()
- weight_scores()

These functions run in the background and are called by the main three
functions as required.

## General Workflow

The general workflow of these functions can be demonstrated as follows:

1.  Take a defined/loaded/calculated dataframe such as this one:

``` r

library(RcTools)

df <- data.frame(
  Basin = c("Black", "Ross", "Haughton", "Suttor"),
  Indicator = c("DIN", "DIN", "Low_DO", "Low_DO"),
  Value = c(0.002, 0.017, 87.6, 104),
  Wqo = c(0.02, 0.02, 90, 90),
  Sf = c(0.38, 0.38, 70, 70),
  Eightieth = c(0.0154, 0.0154, 101.12, 101.12),
  Twentieth = c(0.0026, 0.0026, 75.84, 75.84)
)
```

2.  First run the value_to_score() function. This function takes several
    inputs depending on the type of value and the way you wish to score
    it. In this first example, we are scoring using the freshwater water
    quality method, and therefore are required to supply a large amount
    of information:

``` r

#run the function on our example data
df <- df |> 
  value_to_score(
    value = Value,
    value_type = "Water Quality",
    water_type = "Freshwater",
    indicator = Indicator,
    wqo = Wqo,
    sf = Sf,
    eightieth = Eightieth,
    twentieth = Twentieth
  )
```

This function returns the original table with an additional column
added. The column inherits the name of the value column that was
provided, plus the string “Score” after it. For example if the value
column was named “MyValue”, the new column would be named
“MyValueScore”.

3.  Next the score_to_grade function can be run. In this example we will
    continue using the dataframe from above. However, this function can
    take any number of score columns as inputs and will return the same
    number of new columns with the associated text grade.

``` r

#run the function on our example data
df <- score_to_grade(df, ValueScore)
```

The score to grade function is extremely simple, in all cases just
return letter grades from A to E for scores from 100 to 0.

``` r
#if you wanted to get grades for multiple columns this can be acheived as follows
x <- score_to_grade(x, c(ScoreA, ScoreB, ScoreC))
```

The column(s) inherits the name of the score column that was provided,
plus the string “Grade” after it. Further, if the string “Score” is
detected, it is replaced with “Grade”. For example if the value column
was named “MyValue”, the new column would be named “MyValueGrade”, or if
the column was named “MyValueScore” then the new column would be named
“MyValueGrade”

4.  Finally, a table that has been scored and potentially graded can
    then be saved using the save_n3_table() function. This function is
    unique in that it will apply excel native conditional formatting to
    the outputs of the function. I.e., you can save a dataframe with
    scores, and automatically apply the required colour scaling (red to
    green):

``` r
#save the table
save_n3_table(
  df = df,
  file_name = "my_df",
  target_columns = 8,
  scheme = "Report Card"
)
```

## Value to Score In Detail

The value in score function covers off all standard Report Card scoring
methods, currently this includes scoring for:

- Freshwater Water Quality
- Estuarine Water Quality
- Inshore Water Quality
- Pesticides (FW)
- Wetlands (HWP Specfic)
- Mangroves and Saltmarsh (HWP Specfic)
- Riparian (HWP Specfic)
- Fish

In each case, the required inputs are different. Below, each method of
scoring is presented:

### Freshwater Water Quality

For freshwater water quality scoring, the score is calculated using:

1.  A value,
2.  A water quality objective,
3.  A scaling factor,
4.  The eigtieth pecentile, and
5.  The twentieth percentile.

Additionally, you must specify to the function the type of method you
are trying to score with.

Generally water quality data is stored in a wide format, with each of
the required listed above assigned to its own column, the function has
been structured with this in mind:

``` r

#create example data
df <- data.frame(
  Basin = c("Black", "Ross", "Haughton", "Suttor"),
  Indicator = c("DIN", "DIN", "Low_DO", "Low_DO"),
  Value = c(0.002, 0.017, 87.6, 104),
  Wqo = c(0.02, 0.02, 90, 90),
  Sf = c(0.38, 0.38, 70, 70),
  Eightieth = c(0.0154, 0.0154, 101.12, 101.12),
  Twentieth = c(0.0026, 0.0026, 75.84, 75.84)
)

#run the function on our example data
df <- df |> 
  value_to_score(
    value = Value,
    value_type = "Water Quality",
    water_type = "Freshwater",
    indicator = Indicator,
    wqo = Wqo,
    sf = Sf,
    eightieth = Eightieth,
    twentieth = Twentieth
  )
```

### Estuarine Water Quality

Estuarine water quality is scored using the exact same methodology as
freshwater, however you should change the water_type argument to
“estuarine”.

### Inshore Water Quality

For inshore water quality scoring, the methodology does not require
nearly as much information, only:

1.  A value, and
2.  A water quality objective.

However, you must still specify to the function the type of method you
are trying to score with.

``` r

#create example data
df <- data.frame(
  Basin = c("Black", "Ross", "Haughton", "Suttor"),
  Indicator = c("DIN", "DIN", "Low_DO", "Low_DO"),
  Value = c(0.002, 0.017, 87.6, 104),
  Wqo = c(0.02, 0.02, 90, 90)
)

#run the function on our example data
df <- df |> 
  value_to_score(
    value = Value,
    value_type = "Water Quality",
    water_type = "Marine",
    indicator = Indicator,
    wqo = Wqo
  )
```

### Pesticides, Wetlands, Mangroves and Saltmarsh, Riparian, and Fish

The remaining scoring methodology requires even less information, only:

1.  A value.

However, you must still specify to the function the type of method you
are trying to score with. For example:

``` r

#create example data
df <- data.frame(
  Basin = c("Black", "Ross", "Haughton", "Suttor"),
  Value = c(0.1, 0.6, 0.3, 0.6)
)

#run the function on our example data
df <- df |> 
  value_to_score(
    value = Value,
    value_type = "Pesticides"
  )
```

## Save N3 Table in Detail

The save_n3_table() function also has a range of functionality embedded.
Currently the function can save tables in the following styles:

- Report Card
- Summary Statistic
- Presence/Absence
- Rainfall
- Temperature

The reason for these seemingly disparate options is because in each
case, the table is styled based on conditional formatting.

Each option is demonstrated below:

### Report Card Style

The Report Card style is the classic red to green colour grading. The
condition formatting that is applied here follows the 0 - 100 scale,
where \<21 = red, 21 - \<41 = orange, etc. There is no option to apply
red to green colour scaling for any other number range (such as
non-standardised numbers). This method requires:

- One or more target columns **defined by column number only**,
- The type of scheme to use (“Report Card”),

and optionally can also accept:

- a specified range of target rows (defaults to all rows)
- a request to include a letter grade (defaults to no)

``` r
#create table
df <- data.frame(
  Basin = c("Black", "Ross", "Haughton", "Suttor"),
  DIN = c(51, 76, 27, 98),
  TP = c(90, 57, 34, 72)
)

#save table
save_n3_table(
  df = df, 
  file_name = "my_final_scores", 
  target_columns = 2:3, 
  target_rows = 2:5, 
  scheme = "Report Card",
  include_letter = FALSE
)
```

There are two known limitations to this function. With more time they
could be addressed:

- Column limit of 26. Column numbers are translated to excel column
  letters (e.g. 1 = A, 2 = B). There is currently no method for adapting
  numbers greater than 26 (i.e. where 27 = AA).
- Columns called by number. Currently the function only accepts columns
  input by their number, not by their name. A name to column index
  function could be created.

\## Summary Statistic Styling

The summary statistic styling is used for tables in the HWP appendix and
returns a condition blue/orange for raw values compared against relevant
water quality objectives. This method requires:

- Specifically **one** target column **defined by column number only**,
- The type of scheme to use (“Summary Statistic”),

and optionally can also accept:

- a specified range of target rows (defaults to all rows)

``` r
#create table
df <- data.frame(
  Basin = c("Black", "Ross", "Haughton", "Suttor"),
  value = c(0.001, 10, 0.4, 3),
  wqo = c(0.3, 5, 0.3, 5)
)

#save table
save_n3_table(
  df = df, 
  file_name = "my_summary_statistics_table", 
  target_columns = 2, 
  scheme = "Summary Statistic"
)
```

There are two known limitations to this function. With more time they
could be addressed:

- Single column target only. The function works by comparing the column
  against a neighbour column. If multiple columns are provided the
  comparison fails.
- Hard coded neighbour column. Currently the water quality objective
  must be immediately to the right of the value column otherwise the
  comparison will fail. The function could be rewritten to independently
  target each column.

### Presence/Absence Styling

The presence/absence styling is used for any sort of boolean output and
returns blue for true, and grey/white for false. For example, the
presence/absence of fish detected at each sampling site. This method
requires:

- One or more target columns **defined by column number only**,
- The type of scheme to use (“Presence Absence”),

and optionally can also accept:

- a specified range of target rows (defaults to all rows)

``` r
#create table
df <- data.frame(
  Basin = c("Black", "Ross"),
  Jan = c(3,4),
  Feb = c(4,4),
  Mar = c(5,5),
  Apr = c(3,3)
)

#save table
save_n3_table(
  df = df, 
  file_name = "my_presence_absence_table", 
  target_columns = 2:5, 
  scheme = "Presence Absence"
)
```

There is one known limitations to this function. With more time they
could be addressed:

- Values must be 0 or 1, with 1 indicating presence.

\## Rainfall and Temperature Styling

The rainfall and temperature styling is used specifically for the
summary tables output from the rainfall and temperature (air and sea)
scripts in the climate repository. They colour cells based on category
from 1 - 7 where 1 = “lowest on recored”, 4 = “average” and 7 = “highest
on record”. For rainfall, colours scale from brown to blue, for
temperature colours scale from white to red. This method requires:

- One or more target columns **defined by column number only**,
- The type of scheme to use (“Rainfall” OR “Temperature”),

and optionally can also accept:

- a specified range of target rows (defaults to all rows)

``` r
#create table
df <- data.frame(
  SiteName = c("site1", "site2", "site3", "sit4"),
  species1 = c(0,1,1,1),
  species2 = c(1,1,0,0)
)

#save table
save_n3_table(
  df = df, 
  file_name = "my_rainfall_table", 
  target_columns = 2, 
  scheme = "Rainfall"
)
```

There is one known limitations to this function. With more time they
could be addressed:

- Values must be scaled from 1 to 7.
