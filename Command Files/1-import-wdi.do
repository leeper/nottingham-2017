/*
Created by Richard Ball
Last updated:  2016-09-07
Written for Stata 14--SE, 64-bit, for Windows
*/


clear
set more off

*IMPORT THE IMPORTABLE PEW DATA
import excel using "..\Original Data\original-wdi.xlsx", cellrange(A1:E15) firstrow


*DROP VARIABLE seriesname BECAUSE IT IS REDUNDANT WITH seriescode
drop SeriesName


*THE UNIT OF OBSERVATION IN THE WDI SPREADSHEET
*IS "COUNTRY/SERIES"
*RESHAPE THE SPREADSHEET SO THAT THE UNIT OF OBSERVATION
*IS "COUNTRY" AND EACH VARIABLE IS A SERIES
egen var_no=group(SeriesCode)
drop SeriesCode

rename YR2002 var

reshape wide var, i(CountryCode) j(var_no)

rename var1 exp 
label variable exp "Gov. cons., % of GDP"
rename var2 inc
label variable inc "GDP per capita (current [2002] $ US)"
 

*SO THAT WE CAN MERGE THIS WDI DATA WITH THE PEW DATA,
*GENERATE A VARIABLE country THAT CODES THE COUNTRIES
*IN THE SAME WAY AS THE PEW DATA.
gen country=8 if CountryCode=="CHN"
replace country=17 if CountryCode=="IND"
replace country=18 if CountryCode=="IDN"
replace country=27 if CountryCode=="PAK"
replace country=31 if CountryCode=="RUS"
replace country=40 if CountryCode=="USA"
replace country=45 if CountryCode=="JOR"


*BECAUSE WE HAVE CREATED THE VARIABLE country, 
*WE NO LONGER NEED THE VARIABLE countrycode
*SO WE DROP IT
drop CountryCode 



*SAVE THE MODIFIED DATA SET 
*WITH THE NAME WDI.dta
save "wdi.dta", replace
