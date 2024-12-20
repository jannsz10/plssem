*!mkheader version 0.4.0
*!Written 22Apr2023
*!Written by Sergio Venturini and Mehmet Mehmetoglu
*!The following code is distributed under GNU General Public License version 3 (GPL-3)

program mkheader
	version 15.1
	syntax [, matrix1(string) matrix2(string) DIGits(integer 5) noGRoup ///
		noSTRuctural RAWsum rebus_it(integer -999) rebus_gqi(real 0) ///
		 fimix_it(integer -999) fimix_ll(real 0) GAS CONsistent ]

	/* Options:
	   --------
		 matrix1(string)						--> matrix containing the model assessment
																		indexes
		 matrix2(string)						--> matrix containing the outer weights maximum
																		relative difference history
		 digits(integer 5)					--> number of digits to display (default 5)
		 nogroup										--> multigroup indicator
		 nostructural								--> indicator of whether the model includes a
																		structural part
		 rawsum											--> scores are raw sum of indicators
		 rebus_it										--> number of REBUS-PLS iterations
		 rebus_gqi									--> REBUS-PLS group quality index (GQI)
		 fimix_it										--> number of FIMIX-PLS iterations
		 fimix_ll										--> FIMIX-PLS log-likelihood value attained
		 gas												--> PLS-GAS indicator
		 consistent									--> indicator for consistent PLS (PLSc)
	 */

	local props = e(properties)
	local init : word 1 of `props'
	local wscheme : word 2 of `props'
	local tol = e(tolerance)
	local alllatents = e(lvs)
	local allformative = e(formative)
	local num_lv : word count `alllatents'
	local num_lv_B : word count `allformative'
	local num_lv_A = `num_lv' - `num_lv_B'
  local relative_lbl "relative"
  local isrelative : list relative_lbl in props

	display

	if ("`consistent'" == "") {
		local header "Partial least squares SEM"
	}
	else {
		local header "Consistent partial least squares (PLSc) SEM"
	}
	
  if (`isrelative') {
    local rel_diff "rel. diff."
  }
  else {
    local rel_diff "sq. diff."
  }

	if ((`rebus_it' == -999) & (`fimix_it' == -999) & ("`gas'" == "")) {
		if ("`group'" == "nogroup") {
			if ("`structural'" == "nostructural") {
				local nobs: display _skip(0) "`header'" _col(49) ///
					"Number of obs" _col(69) "=" _skip(5)
				display as text "`nobs'" _continue
        display as result e(N)
				
				display

				local init_head: display _skip(0) "Initialization: "
				display as text "`init_head'" _continue
        display as result "`init'"
			}
			else {
				if ("`rawsum'" == "") {
					local niter = colsof(`matrix2')
					forvalues i = 1/`niter' {
						local iter_lbl = "Iteration " + string(`i') + ///
							": outer weights " + "`rel_diff'" + " = "
						display as text _skip(0) "`iter_lbl'" _continue
            display as result string(`matrix2'[1, `i'], "%9.`digits'e")
					}
					
					display
				}
				
				local nobs: display _skip(0) "`header'" _col(49) ///
					"Number of obs" _col(69) "=" _skip(5)
				display as text "`nobs'" _continue
        display as result e(N)

				if (`num_lv_A' > 0) {
					local avrsq: display _skip(0) _col(49) "Average R-squared" _col(69) ///
						"=" _skip(5)
					display as text "`avrsq'" _continue
          display as result string(`matrix1'[1, 1], "%9.`digits'f")
					
					local avave: display _skip(0) _col(49) "Average communality" ///
						_col(69) "=" _skip(5)
					display as text "`avave'" _continue
          display as result string(`matrix1'[1, 2], "%9.`digits'f")
				}
				else {
					display
				}

				if ("`rawsum'" == "") {
					local gof: display _skip(0) "Weighting scheme: "
          display as text "`gof'" _continue
          display as result "`wscheme'" _col(49) _continue
				}
				else {
					local gof: display _skip(0) "Weighting scheme: "
          display as text "`gof'" _continue
          display as result "rawsum" _col(49) _continue
				}
				if (`num_lv_A' > 0) {
					local gof: display "Absolute GoF" _col(69) "=" _skip(5)
          display as text "`gof'" _continue
          display as result string(`matrix1'[1, 3], "%9.`digits'f")
				}
        else {
          display
        }
				
				if ("`rawsum'" == "") {
					local gof_rel: display _skip(0) "Tolerance: "
          display as text "`gof_rel'" _continue
          display as result string(`tol', "%9.`digits'e") _col(49) _continue
				}
				else {
					local gof_rel: display _skip(0) _col(49)
          display as text "`gof_rel'" _continue
				}
				if (`num_lv_A' > 0) {
					local gof_rel: display "Relative GoF" _col(69) "=" _skip(5)
          display as text "`gof_rel'" _continue
          display as result string(`matrix1'[1, 4], "%9.`digits'f")
				}
        else {
          display
        }
				
				if ("`rawsum'" == "") {
					local avred: display _skip(0) "Initialization: "
          display as text "`avred'" _continue
          display as result "`init'" _col(49) _continue
				}
				else {
					local avred: display _skip(0) _col(49)
          display as text "`avred'" _continue
				}
				if (`num_lv_A' > 0) {
					local avred: display "Average redundancy" _col(69) "=" _skip(5)
          display as text "`avred'" _continue
          display as result string(`matrix1'[1, 5], "%9.`digits'f")
				}
        else {
          display
        }
			}
		}
		else {
			local title: display _skip(0) "`header'"
			display as text "`title'"
			
			display
			
			if ("`structural'" == "nostructural") {
				local initialize: display _skip(0) "Initialization: "
				display as text "`initialize'" _continue
        display as result "`init'"
			}
			else {
				if ("`rawsum'" == "") {
					local wgt: display _skip(0) "Weighting scheme: "
					display as text "`wgt'" _continue
          display as result "`wscheme'"
					
					local toler: display _skip(0) "Tolerance: "
					display as text "`toler'" _continue
          display as result string(`tol', "%9.`digits'e")
				}
				else {
					local wgt: display _skip(0) "Weighting scheme: "
					display as text "`wgt'" _continue
          display as result "rawsum"
				}
				
				if ("`rawsum'" == "") {
					local initialize: display _skip(0) "Initialization: "
          display as text "`initialize'" _continue
          display as result "`init'"
				}
				else {
					local initialize: display _skip(0)
          display as text "`initialize'"
				}
			}
		}
	}
	else if ((`rebus_it' > 0) & (`fimix_it' == -999) & ("`gas'" == "")) {
		local title: display _skip(0) "Response-based unit segmentation partial least squares (REBUS-PLS)"
		display as text "`title'"
		
		display

		local wgt: display _skip(0) "Weighting scheme: "
		display as text "`wgt'" _continue
    display as result "`wscheme'"
		
		local toler: display _skip(0) "Tolerance: "
		display as text "`toler'" _continue
    display as result string(`tol', "%9.`digits'e")

		local initialize: display _skip(0) "Initialization: "
		display as text "`initialize'" _continue
    display as result "`init'"
		
		local rebit: display _skip(0) "Number of REBUS-PLS iterations: "
		display as text "`rebit'" _continue
    display as result "`rebus_it'"
		
		local rebgqi: display _skip(0) "Group Quality Index (GQI): "
		display as text "`rebgqi'" _continue
    display as result string(`rebus_gqi', "%9.`digits'f")
	}
	else if ((`rebus_it' == -999) & (`fimix_it' > 0) & ("`gas'" == "")) {
		local title: display _skip(0) "Finite mixture partial least squares (FIMIX-PLS)"
		display as text "`title'"
		
		display

		local wgt: display _skip(0) "Weighting scheme: "
		display as text "`wgt'" _continue
    display as result "`wscheme'"
		
		local toler: display _skip(0) "Tolerance: "
		display as text "`toler'" _continue
    display as result string(`tol', "%9.`digits'e")

		local initialize: display _skip(0) "Initialization: "
		display as text "`initialize'" _continue
    display as result "`init'"
		
		local fimit: display _skip(0) "Number of FIMIX-PLS iterations: "
		display as text "`fimit'" _continue
    display as result "`fimix_it'"
		
		local fimll: display _skip(0) "Log-likelihood value: "
		display as text "`fimll'" _continue
    display as result string(`fimix_ll', "%99.`digits'f")
	}
	if ("`gas'" != "") {
		local title: display _skip(0) "Partial least squares genetic algorithm segmentation (PLS-GAS)"
		display as text "`title'"
		
		display

		local wgt: display _skip(0) "Weighting scheme: "
		display as text "`wgt'" _continue
    display as result "`wscheme'"
		
		local toler: display _skip(0) "Tolerance: "
		display as text "`toler'" _continue
    display as result string(`tol', "%9.`digits'e")

		local initialize: display _skip(0) "Initialization: "
		display as text "`initialize'" _continue
    display as result "`init'"
	}
end
