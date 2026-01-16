* Stata Replication Code for Lecture 09
* Difference-in-Differences and Instrumental Variables

* set working directory
cd "/Users/jacobgosselin/Documents(local)/GitHub/CausalitySlides"
*------------------------------------------------------------------------------
* Example 1: Instrumental Variables - US Consumption Data
*------------------------------------------------------------------------------

* Load the data
import delimited "data/usconsump1993.csv", clear
* generate lagged investment variable and time variable 
gen year = _n + 1949
tsset year
gen lastyr_invest = L.income - L.expenditure
* 2SLS estimation: instrument income with lagged investment
ivregress 2sls expenditure (income = lastyr_invest), vce(robust)
* Export neatly (label variables first)
label variable expenditure "Expenditure"
label variable income "Income"
label variable lastyr_invest "Lagged Investment"
esttab using "tables/stata_replication_iv.tex", replace ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) label

*------------------------------------------------------------------------------
* Example 2: Difference-in-Differences - Injury Data
*------------------------------------------------------------------------------

* Load the data
import delimited "data/injury_ky.csv", clear
* TWFE DiD regression with fixed effects for group (highearn) and time (afchnge)
reghdfe ldurat treated, absorb(highearn afchnge) vce(robust)
* Export neatly (label variables first)
label variable ldurat "Length of Disability"
label variable treated "Treatment Indicator"
esttab using "tables/stata_replication_did.tex", replace ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) label


