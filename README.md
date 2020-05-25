Statistical Analysis of UNDP GII and HDI data of countries in R.
R Script file: GII_Script.R
Detailed Report with created graphs and outputs: UNDP_GII_Analysis.docx
Required data files uploaded.


Introduction:
United Nations Development Programme (UNDP) calculates the Gender Inequality Index (GII), which aims to measure disparities between males and females in a region / country, and highlight areas in need of critical policy intervention, according to according to the GII - United Nations Development Report, available on “http://data.un.org/DocumentData.aspx?q=gender&id=391” (Accessed: 04-April-2019)
There has been a global effort to increase female representation in parliaments. It is hoped that greater representation of women in legislature would help highlight gender inequality issues more effectively, and lead to reduction in gender disparities.
According to Katica Roy, “How Fewer Women in Politics Impacts Policy and the Economy”, 07-Mar-2018, Women in elected office focus on health (including women’s health), among other issues.
Similarly, we would expect higher education levels and labour force participation rates of women to positively impact gender equality.
Objective:
1.	Understand and quantify the effect of ratio of women in parliament, percentage of women with at least secondary education and participation of women in labour force (dependent variables) on adolescent birth rates (independent variable)
2.	Estimate the power of GII in predicting if a country belongs to the Low HDI group.
Data Pre-Processing and Preliminary Analysis:
Data Sources:
The data used is the Gender Inequality Index data from the United Nations Development Programme’s Human Development Report 2018:
“http://data.un.org/DocumentData.aspx?q=gender&id=391”
Columns used from dataset:
Country (country): with 191 countries
Adolescent birth rate (ABR): Number of births to women ages 15-19 per 1,000 women ages 15-19. 
Population with at least some secondary education (SEC): Percentage of the population ages 25 and older that has reached (but not necessarily completed) a secondary level of education.
Share of seats in parliament (PARL): Proportion of seats held by women in the national parliament expressed as percentage of total seats. For countries with a bicameral legislative system, the share of seats is calculated based on both houses.
Labour force participation rate (LABF): Proportion of the working-age population (ages 15 and older) that engages in the labour market, either by working or actively looking for work, expressed as a percentage of the working-age population.

Separate datasets from data.un.org are used for historical values of ratio of women in politics and ratio of girls in education.
http://data.un.org/_Docs/SYB/CSV/SYB61_T05_Seats%20held%20by%20Women%20in%20Parliament.csv
http://data.un.org/_Docs/SYB/CSV/SYB61_T05_Seats%20held%20by%20Women%20in%20Parliament.csv

Preparing Data for Software:
The data files have been pre-processed to prepare the data for analysis on software R.
The UNDP GII data includes the columns HDI rank and GII score, which are calculated based on the independent variables. These present redundant information in the context of our model, and have been removed using MS Excel, along with other additional columns. 
In the historical data on % women in politics and ratio of girls in education, the average of these values by country were calculated using the MS Excel Pivot function, and added to the data file.

* Assumptions:
Linear Regression makes no assumptions regarding the distribution of the variables.
The method makes several assumptions regarding the model like:
1.	Linear relationship between outcome and predictor variables
2.	No multicollinearity between independent variables
3.	Homoscedasticity and Independence of Errors
4.	There are no influential data points
The model needs to be tested against these assumptions.


* Findings 
It is found that the share of women in parliament is not a significant variable in predicting the Adolescent Birth Rate in a country.
The Percentage of women with secondary education, and Labour Force participation are both significant, with coefficients -0.86 and 0.47 respectively.
The positive coefficient for Labour Force participation maybe viewed as surprising, as this indicates that counties with higher labour force participation on women, also have higher adolescent birth rate.
Although the ratio of girls to boys in Primary education is a significant variable, it cannot be used to estimate a linear model, due to lack of linearity with Adolescent Birth Rate, the dependent variable.
It may be possible to use further Non-Linear transformation techniques, for ex Box-Cox transformation, on this variable, to see if it can improve the model.
The linear model to estimate the Adolescent Birth Rate is heteroscedastic. It is desirable that more missing variables are identified and introduced to attempt to improve the model.
It is found that the Gender Inequality Index is able to predict whether a country belongs to the Low HDI group, with a 91% accuracy.
An increase in the GII score by 0,01 increases the likelihood of a country being Low HDI by 1.2 times, or 20%. 

Please refer to full report in UNDP_GII_Analysis.doc

