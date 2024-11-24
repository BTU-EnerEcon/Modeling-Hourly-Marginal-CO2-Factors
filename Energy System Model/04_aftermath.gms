parameter
gen_gas(year_focus,month,day,hour,n)
gen_oil(year_focus,month,day,hour,n)
gen_coal(year_focus,month,day,hour,n)
gen_lig(year_focus,month,day,hour,n)
gen_nuc(year_focus,month,day,hour,n)
gen_hydro(year_focus,month,day,hour,n,i)

price(year_focus,month,day,hour,n)
generation_all(year_focus,month,day,hour,n,i)

emissions(year_focus,month,day,hour,n,i)
emiss_intens(year_focus,month,day,hour,n)


primary_energy_factor(year_focus,month,day,hour,n,i)
pmf(year_focus,month,day,hour,n,i)


generation_nuc_monthly(year_focus,month,n)
generation_lig_monthly(year_focus,month,n)
generation_coal_monthly(year_focus,month,n)
generation_gas_monthly(year_focus,month,n)
generation_hyRes_monthly(year_focus,month,n)
generation_PSP_monthly(year_focus,month,n)

Pon_all(year_focus,month,day,hour,n,i)

storage_cluster_activity(year_focus,month,day,hour,n)
StLevel(year_focus,month,day,hour,n)
Reservoir_activity(year_focus,month,day,hour,n)
PSP_pump(year_focus,month,day,hour,n)
PSP_charge(year_focus,month,day,hour,n)
PSP_Gen(year_focus,month,day,hour,n)
X_demand(year_focus,month,day,hour,n)
Curt_RES(year_focus,month,day,hour,n)

export(year_focus,month,day,hour,n,nn)
import(year_focus,month,day,hour,n,nn)

PrimaryReserve(year_focus,month,day,hour,i)
SecondaryReserve_pos(year_focus,month,day,hour,i)
SecondaryReserve_neg(year_focus,month,day,hour,i)

generation_all_monthly(year_focus,month,n,i)
generation_thermal_monthly(year_focus,month,n,i)
generation_gas_monthly(year_focus,month,n)
generation_coal_monthly(year_focus,month,n)
generation_lignite_monthly(year_focus,month,n)
generation_oil_monthly(year_focus,month,n)
generation_biowaste_monthly(year_focus,month,n)

export_monthly(year_focus,month,n,nn)
import_monthly(year_focus,month,n,nn)
tradebalance_monthly(year_focus,month,n,nn)


;

** RELEVANT PARAMETERS

price(year_focus,month,day,hour,n)               = sum(daily_window, price_roll(year_focus,month,day,hour,n,daily_window)     );

generation_all(year_focus,month,day,hour,n,i)      = sum(daily_window, generation_all_roll(year_focus,month,day,hour,n,i,daily_window) );



*generation_all_monthly(year_focus,month,n,i)           = sum(daily_window, generation_all_roll_monthly(year_focus,month,n,i,daily_window) )        ;
*$ontext
generation_nuc_monthly(year_focus,month,n)         = sum(daily_window, generation_roll_monthly_nuc(year_focus,month,n,daily_window) )      ;
generation_lig_monthly(year_focus,month,n)         = sum(daily_window, generation_roll_monthly_lig(year_focus,month,n,daily_window) )      ;
generation_coal_monthly(year_focus,month,n)        = sum(daily_window, generation_roll_monthly_coal(year_focus,month,n,daily_window) )     ;
generation_gas_monthly(year_focus,month,n)         = sum(daily_window, generation_roll_monthly_gas(year_focus,month,n,daily_window) )      ;
generation_hyRes_monthly(year_focus,month,n)       = sum(daily_window, generation_roll_monthly_hydroRes(year_focus,month,n,daily_window) ) ;
generation_PSP_monthly(year_focus,month,n)         = sum(daily_window, generation_roll_monthly_PSP(year_focus,month,n,daily_window) )      ;


emissions(year_focus,month,day,hour,n,lignite) = ( generation_all(year_focus,month,day,hour,n,lignite) *  carbon_content(lignite) )/ eta_fl(lignite,n) ;
emissions(year_focus,month,day,hour,n,coal) = ( generation_all(year_focus,month,day,hour,n,coal) *  carbon_content(coal) )/ eta_fl(coal,n) ;
emissions(year_focus,month,day,hour,n,gas) = ( generation_all(year_focus,month,day,hour,n,gas) *  carbon_content(gas) )/ eta_fl(gas,n) ;
emissions(year_focus,month,day,hour,n,oil) = ( generation_all(year_focus,month,day,hour,n,oil) *  carbon_content(oil) )/ eta_fl(oil,n) ;

emiss_intens(year_focus,month,day,hour,n) = sum(i, emissions(year_focus,month,day,hour,n,i)) / sum(i, generation_all(year_focus,month,day,hour,n,i)) ;

%xDem%   X_demand(year_focus,month,day,hour,n)   = sum(daily_window, X_demand_roll(year_focus,month,day,hour,n,daily_window) );
         Curt_RES(year_focus,month,day,hour,n)   = sum(daily_window, Curt_RES_roll(year_focus,month,day,hour,n,daily_window) );



EXECUTE_UNLOAD '%output_dir%%result%.gdx'    price
*                
               , emissions
               , generation_all      
               ,demand
               , modelstats, solvestats

;
$stop

$onecho >out.tmp

          par=price                         rng=price!A1:AJ9999    rdim=4 cdim=1
*         par=generation_all                rng=Generation!A1      rdim=4 cdim=2
*         par=Pon_all                       rng=P_on!A1            rdim=4 cdim=1
          par=generation_nuc_monthly        rng=G_nuc!A1           rdim=2 cdim=1
          par=generation_lig_monthly        rng=G_lig!A1           rdim=2 cdim=1
          par=generation_coal_monthly       rng=G_coal!A1          rdim=2 cdim=1
          par=generation_gas_monthly        rng=G_gas!A1           rdim=2 cdim=1
          par=generation_hyRes_monthly      rng=G_hyRes!A1         rdim=2 cdim=1
          par=generation_PSP_monthly        rng=G_PSP!A1           rdim=2 cdim=1

*         par=storage_activity              rng=PSP!A1             rdim=4 cdim=1
*         par=Reservoir_activity            rng=Reservoir!A1:O9999 rdim=4 cdim=1
*         par=PSP_pump                      rng=Pump!A1            rdim=4 cdim=1
*         par=PSP_Gen                       rng=PSP!W1             rdim=4 cdim=1
*         par=PSP_charge                    rng=Pump!W1            rdim=4 cdim=2
*         par=StLevel                       rng=StLevel!A1         rdim=4 cdim=1
%xDem%    par=X_demand                      rng=x_dem!A1           rdim=4 cdim=1
*%ConPow% par=PrimaryReserve                rng=CP_pr!A1           rdim=4 cdim=1
*%ConPow% par=SecondaryReserve_pos          rng=CP_sec_pos!A1      rdim=4 cdim=1
*%ConPow% par=SecondaryReserve_neg          rng=CP_sec_neg!A1      rdim=4 cdim=1

*         par=tradebalance_monthly          rng=tradebalance!A1    rdim=2 cdim=2

          par=modelstats                    rng=stats!A2:B9900     rdim=1 cdim=0
          par=solvestats                    rng=stats!D2:E9900     rdim=1 cdim=0

$offecho

execute "XLSTALK -c    %output_dir%%result%.xlsx" ;

EXECUTE 'gdxxrw %output_dir%%result%.gdx o=%output_dir%%result%.xlsx EpsOut=0 @out.tmp'
;
