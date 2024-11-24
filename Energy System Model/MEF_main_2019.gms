$ontext
Dispatch model used for "Advanced Models foor Hourly Marginal CO2 Emission Factor Estimation:
a synergy between fundamental and statistical approches."

LSEW BTU

$offtext


*#############################  DEFAULT OPTIONS  #############################
$eolcom #

$setglobal Before2015 "*"      # if "*" then outages included, if "" then constant availability factor

$setglobal Store  ""      # if "*" the storage functions excluded, if "" storage functions included
$setglobal Reserv  ""     # if "*" the reservoir functions excluded, if "" reservoir functions included
$setglobal Startup ""     # if "*" the startup functions excluded, if "" startup functions included
$setglobal Flow   ""      # if "*" the trade excluded, if "" trade included
$setglobal CHP   ""       # if "*" the trade excluded, if "" trade included
$setglobal xDem  ""       # if "*" the demand increase excluded, if "" demand increase included
$setglobal ConPow ""      # if "*" Control Power excluded, if "" Control Power included
$setglobal min_downtime "*"  # if "*" minimum downtime excluded, if "" minimum downtime included

$ifthen "%Store%" == ""     $setglobal exc_Store "*"
$else                       $setglobal exc_Store ""
$endif

$ifthen "%Reserv%" == ""     $setglobal exc_Reserv "*"
$else                       $setglobal exc_Reserv ""
$endif

$ifthen "%Startup%" == ""   $setglobal exc_Startup "*"
$else                       $setglobal exc_Startup ""
$endif



*#####################  DIRECTORIRY and FILE MANAGEMENT  #####################

$setglobal YearonFocus "2019"

*Location of input files
$setglobal datadir                data\
$setglobal DataIn_yearly               InputData%YearonFocus%_diffyweather
$setglobal DataIn_general             InputData_allyears

*Location of output files
$setglobal output_dir   outputM2\
$setglobal result       R1_diffyweather

set
    daily_window  all days of the model horizon /day1*day190/

    t      all hours                       / t1*t4536  /
;
*t4536

alias(daily_window, daily_set) ;

*#############################   DATA LOAD     ###############################

$include 01_declare_parameters.gms

*#############################   REPORTING INPUT ###############################

execute_unload '%datadir%Input_final.gdx'


*$stop

$include CHP_check.gms
*#############################   MODEL     #####################################

*$include 02_MODEL.gms
*$include 02_MODEL_2ndObj.gms
$include 02_MODEL.gms

*#############################   SOLVING     ###################################

*$include 03_loop_MarginalDaily.gms
$include 03_loop.gms

*#############################   results     #################################

*$include 04_aftermath_MarginalDaily.gms
$include 04_aftermath.gms











