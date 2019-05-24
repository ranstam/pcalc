********************************************************************************
* Programme       : pcalc.ado                                                  *
* Programmer      : Jonas Ranstam                                              *
* Programmed date : 18.07.2015                                                 *
********************************************************************************

*! pcalc v1.0.0 JRanstam 18jul2015

program define pcalc, rclass
   version 14
   
/* 
Syntax: pcalc b se df [dec]

Where b   is the parameter estimate
      se  is the standard error is the paramater estimate
      df  is the degrees of freedom
      dec is the number of decimals for the confidence interval limits
*/   
   args b se df dec
  
   if ("`dec'"=="") local d=2 
   else local d=`dec' 

   local br : di %8.`d'f `b'
   local pv : di %8.4f 2*ttail(`df',abs(`b'/`se'))
   local ll : di %8.`d'f `b'-invttail(`df',0.025)*`se'
   local ul : di %8.`d'f `b'+invttail(`df',0.025)*`se'
           
   display as txt "p-value = " as res `pv' as txt " (95%Ci: " as res `ll' as txt " to " as res `ul' as txt ")"

   return scalar b=`br'
   return scalar p=`pv'
   return scalar ll95=`ll'
   return scalar ul95=`ul'

end
