{smcl}
{* *! version 0.6.1  29May2024}{...}
{vieweralsosee "plssem postestimation" "help plssem postestimation"}{...}
{vieweralsosee "plssemplot" "help plssemplot"}{...}
{vieweralsosee "plssemc" "help plssemc"}{...}
{viewerjumpto "Syntax" "plssem##syntax"}{...}
{viewerjumpto "Description" "plssem##description"}{...}
{viewerjumpto "Options" "plssem##options"}{...}
{viewerjumpto "Examples" "plssem##examples"}{...}
{viewerjumpto "Authors" "plssem##authors"}{...}
{viewerjumpto "Stored results" "plssem##results"}{...}
{viewerjumpto "References" "plssem##references"}{...}
{title:Title}

{p 4 18 2}
{hi:plssem} {hline 2} Partial least squares structural equation modelling (PLS-SEM)


{marker syntax}{...}
{title:Syntax}

{pstd}
Partial least squares structural equation modeling of data

{p 8 12 2}
{cmd:plssem} (LV1 > indblock1) (LV2 > indblock2) (...) {ifin}
[{cmd:,} structural(LV2 LV1, ...) {it:{help plssem##plssemopts:options}}]


{pstd}
Partial least squares structural equation modeling of adjacency matrices

{p 8 15 2}
{cmd:plssemmat} {it:adjmeas_matname} {ifin}
[{cmd:,} structural({it:adjstruc_matname}) {it:{help plssem##plssemopts:options}}]


{phang}
{it:adjmeas_matname} is a Q x P matrix providing the adjacency matrix for the
measurement model, while {it:adjstruc_matname} is a P x P matrix providing the
adjacency matrix for the structural model (Q denotes the number of indicators
and P the number of latent variables in the model).

{synoptset 19 tabbed}{...}
{marker plssemopts}{...}
{synopthdr}
{synoptline}
{synopt:{cmdab:w:scheme(centroid)}}use the centroid weighting scheme{p_end}
{synopt:{cmdab:w:scheme(factorial)}}use the factorial weighting scheme{p_end}
{synopt:{cmdab:w:scheme(path)}}use the path weighting scheme; the default{p_end}
{synopt:{opth bin:ary(syntax##description_of_namelist:namelist)}}list of latent variables to fit using {helpb logit}{p_end}
{synopt:{opth b:oot(numlist)}}number of bootstrap replications{p_end}
{synopt:{opth s:eed(numlist)}}bootstrap seed number{p_end}
{synopt:{opt t:ol(#)}}tolerance; default is {cmd:1e-7}{p_end}
{synopt:{opt max:iter(#)}}maximum number of iterations; default is {cmd:100}{p_end}
{synopt:{cmdab:miss:ing(mean)}}impute the indicator missing values using the mean of the available indicators{p_end}
{synopt:{cmdab:miss:ing(knn)}}impute the indicator missing values using the k-th nearest neighbor method{p_end}
{synopt:{opt k(#)}}number of nearest neighbors to use with {cmd:missing(knn)}; default is {cmd:5}{p_end}
{synopt:{cmdab:init(eigen)}}initialize the latent variables using {helpb factor}{p_end}
{synopt:{cmdab:init(indsum)}}initialize the latent variables using the sum of indicators; the default{p_end}
{synopt:{opt dig:its(#)}}number of digits to display; default is {cmd:3}{p_end}
{synopt:{cmd:no}{cmdab:head:er}}suppress display of output header{p_end}
{synopt:{cmd:no}{cmdab:meas:table}}suppress display of measurement model estimates table{p_end}
{synopt:{cmd:no}{cmdab:discrim:table}}suppress display of discriminant validity table{p_end}
{synopt:{cmd:no}{cmdab:struct:table}}suppress display of structural model estimates table{p_end}
{synopt:{opt loadp:val}}show the outer loadings' p-values{p_end}
{synopt:{opt stat:s}}print a table of summary statistics for the indicators{p_end}
{synopt:{opt gr:oup()}}perform multigroup analysis; see {help plssem##options:{it:Options}} for details{p_end}
{synopt:{opt corr:elate()}}report the correlation among indicators, latent variables and cross loadings; see {help plssem##options:{it:Options}} for details{p_end}
{synopt:{opt raw:sum}}estimate the latent scores as the raw sum of the indicators{p_end}
{synopt:{cmd:no}{cmdab:sc:ale}}manifest variables are not standardized before running the algorithm{p_end}
{synopt:{cmdab:conv:crit(relative)}}relative convergence criterion; the default{p_end}
{synopt:{cmdab:conv:crit(square)}}square convergence criterion{p_end}
{synopt:{opth ord:inal(varlist)}}list of ordinal indicators{p_end}
{synopt:{cmdab:rob:ust(none)}}use non-robust correlation measures (see below for more details){p_end}
{synopt:{cmdab:rob:ust(spearman)}}use the Spearman rank correlation measure{p_end}
{synopt:{cmdab:rob:ust(mcd)}}use a robust correlation measure (minimum covariance determinant, MCD){p_end}
{synoptline}

{p 4 6 2}
{cmd:by} is allowed with {cmd:plssem}; see {help prefix}.

{p 4 6 2}
See {helpb plssem_postestimation:plssem postestimation} and {helpb plssemplot:plssemplot} for features available after estimation.{p_end}

{pstd}The syntax of {cmd:plssem} reflects the measurement and structural part of a PLS-SEM model,
and accordingly requires the user to specify both of these parts simultaneously. Since a
full PLS-SEM model would include a structural model, i.e., the relationship between latent
variables (LV), one needs to have at least two latent variables specified in the measurement
part. Each latent variable will be defined by a block of indicators (say, {cmd:indblock}). For
example, if we have two latent variables in our PLS-SEM model, the {cmd:plssem} syntax requires to
specify the measurement part by typing {cmd:(LV1 > indblock1) (LV2 > indblock2)} following
the command name. Note that we can specify as many LVs as it is needed in the model.

{pstd}Incidentally, when specifying reflective measures, one needs to use the greater-than sign between 
a latent variable and its associated indicators (e.g., {cmd:LV1 > indblock1}) and the less-than sign 
for formative measures (e.g., {cmd:LV1 < indblock1}).

{pstd}To specify the structural part, one simply needs to type in the endogenous/dependent LV first
and then the exogenous latent variable/s, e.g., {cmd:structural(LV2 LV1)}. One can specify more than one
structural relationship following the same approach. Say that we have two further latent variables
in the model, {cmd:LV3} and {cmd:LV4}; then, in the structural part of the syntax we would type in
{cmd:structural(LV2 LV1, LV4 LV3)} indicating that {cmd:LV4} is another endogenous LV predicted by
{cmd:LV3}. In addition, in line with most of the Stata commands, one can fit a full PLS-PM model by
subsetting the data directly in the syntax using the {cmd:if} and {cmd:in} qualifers.

{pstd}In {cmd:plssemmat} row and column names of the adjacency matrices provided
are used in the output. Note that, no matter whether {cmd:plssem} or {cmd:plssemmat}
is used, the raw data are still needed. The difference between the two commands is how
the model is specified: through an equation-like style for {cmd:plssem} and with the
adjacency matrices for {cmd:plssemmat}.

{pstd}In {cmd:plssemmat} each column name of the measurement model adjacency matrix
must specify either "Reflective:" or "Formative:" as the equation names of the columns (see the
examples below).


{marker description}{...}
{title:Description}

{pstd} {bf:plssem} fits partial least squares structural equation models (PLS-SEM), which is 
often considered as an alternative to the commonly known covariance-based structural equation 
modeling (COV-SEM). {bf:plssem} is developed in line with the algorithm provided by 
{help plssem##Wold1975:Wold (1975)} and {help plssem##Lohmoller1989:Lohmöller (1989)}. {bf:plssem} can be used for modeling the relationship 
among single-item observed variables too and not only for latent variable modeling.
 
{pstd} The algorithm used to estimate a PLS-SEM model consists basically of three sequential stages
of estimation (see {help plssem##Lohmoller1989:Lohmöller 1989}). In the first stage, latent variable scores are estimated for each
case. Using these scores, in the second stage, measurement model parameters (weights/loadings)
are estimated. In the same manner, in the third stage structural model parameters (path
coefficients) are finally estimated. The first stage is what makes PLS-SEM a novel method
in that the second and third stages are about conducting a series of regression analysis using the 
ordinary least squares method. 


{marker options}{...}
{title:Options}

{phang}{opt wscheme(weighting_scheme)}
provides the choice of the weighting scheme. The default is
{bf:path} for the path scheme. Alternative choices are {bf:factorial} or {bf:centroid} for the
corresponding scheme.

{phang}{opt binary(LV)}
indicates the latent variables that are defined by a single binary variable. This
allows essentially for estimating a model with a binary dependent variable using a logistic
regression model. The {bf:LV} needs to be specified in the measurement part of the syntax
at the same time (e.g., {bf:LV > binaryvar1)}.

{phang}{opt boot(#)}
sets the number of bootstrap replications. 

{phang}{opt seed(#)}
sets the seed number for the bootstrap calculations. This option may be useful if
reproducibility is the analyst's concern. 

{phang}{opt tol(#)}
sets the tolerance value used for checking convergence attainment. The default tolerance
value is 1e-7. 

{phang}{opt maxiter(#)}
indicates the maximum number of iterations the algorithm runs. The default is
100 iterations. Note that usually the algorithm requires a very limited number of
iterations to reach convergence, typically less than 10. 

{phang}{opt missing(imputation_method)}
provides the choice for the method to use for imputing the indicator missing values. Possible
choices are {bf:mean} (i.e. the mean of the available indicators) or {bf:knn} (i.e. the k-th
nearest neighbor method).

{phang}{opt k(#)}
sets the number of nearest neighbors to use with {cmd:missing(knn)}. The default
number of nearest neighbors is 5.

{phang}{opt init(init_method)}
lets the user choose between two options for initialization. These
are {bf:indsum} (default) and {bf:eigen}. The {bf:eigen} option also allows the user estimate only the
measurement part of the model.

{phang}{opt digits(#)}
sets the number of decimals to display the model estimates. The default is 3. 

{phang}{opt noheader}
suppresses the output header. 

{phang}{opt nodiscrimtable}
suppresses discriminant validity assessment section of the output. 

{phang}{opt nomeastable}
suppresses measurement model section of the output. 
 
{phang}{opt nostructtable}
suppresses structural model section of the output. 

{phang}{opt loadpval}
shows the table of loadings' p-values. 

{phang}{opt stats}
displays some summary statistics (mean, standard deviations, etc.) for the original
indicators. 

{phang}{opt group(grouping_variable, [sub-options])}
provides both the structural and the measurement part of the estimation
results for each category of the grouping variable as well as the comparison
between the categories based on normal-theory (default). As an alternative to
normal-based theory estimations, the user can use two resampling techniques. More
specifically, by adding the suboption {bf:method(permutation} or {bf:bootstrap)} one
can get the results based on permutation or bootstrap resampling. The default number
of replications for both permutation and bootstrap is 100. However, this can be
changed by adding the suboption {bf:reps(#)}. Further, with the suboption {bf:groupseed(#)}
one can also set a certain seed number to be able reproduce the bootstrap or permutation
results. By specifying the suboption {bf:plot} we can get a graphical output
showing the estimates differences between the groups based on alpha level of 0.05
(default). The significance level can also be changed by adding the suboption
{bf:alpha(#)}. Finally, the {bf:unequal} suboption indicates that unequal variances
must be assumed in the parametric bootstrap test.

{phang}{opt correlate(mv lv cross [, cutoff(#)])}
lets the user ask for correlations among the indicators
or manifest variables ({bf:mv}), latent variables ({bf:lv}) as well as cross-loadings ({bf:cross})
between the indicators and latent variables. When doing so, the user can also set a certain
cut-off value for the correlations to be displayed by using the suboption {bf:cutoff(#)}.
For instance, {bf:cutoff(0.3)} will display the correlations above 0.3 in absolute terms.

{phang}{opt rawsum}
uses the sum of the raw indicators and the resulting aggregated scores (also called
summated scales) are used directly for estimating the structural part. In this sense, {cmd:rawsum}
is an alternative procedure to the PLS-algorithm for estimating the latent variable
scores. 

{phang}{opt noscale}
the manifest variables are not standardized before running the algorithm.

{phang}{opt convcrit(convergence_criterion)}
the convergence criterion to use. Alternative choices are {bf:relative} or {bf:square}. The
default is {bf:relative}.

{phang}{opt ordinal(ind)}
specifies the list of indicators to treat as ordinal; for these variables, the polyserial
or polychoric measures are used to assess the correlation with the other indicators. In
other terms, this option implements a version of ordinal PLS (OrdPLS) approach (see {help plssem##CantaluppiBoari2016:Cantaluppi and Boari 2016})

{phang}{opt robust(corr_method)}
specifies the method to use for computing the correlation among the indicators. If
{it:corr_method} is set to {bf:none}, the standard Bravais-Pearson correlation is used
if the indicators are numerical, while the polyserial or polychoric correlations are
used for the ordinal/categorical indicators (OrdPLS). If {it:corr_method} is set to
{bf:spearman}, the Spearman rank correlation measure is used. Finally, if
{it:corr_method} is set to {bf:mcd}, the minimum covariance determinant (MCD) approach
is used (see {help plssem##RousseeuwvanDriessen1999:Rousseeuw and K. van Driessen 1999}). The latter provides an implementation of the robust PLS (Robust PLS) approach (see {help plssem##Schambergeretal2020:Schamberger et al. 2020}).


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse workout2, clear}{p_end}

{pstd}Model estimation{p_end}
{phang2}{cmd:. plssem (Attractive > face sexy) (Appearance > body appear attract) (Muscle > muscle strength endur) (Weight > lweight calories cweight), structural(Appearance Attractive, Muscle Appearance, Weight Appearance)}{p_end}

{pstd}Inner model graph{p_end}
{phang2}{cmd:. plssemplot, innermodel}{p_end}

{pstd}Outer weights evolution{p_end}
{phang2}{cmd:. plssemplot, outerweights}{p_end}

{pstd}Direct, indirect and total effects graph{p_end}
{phang2}{cmd:. estat total, plot}{p_end}

{pstd}Multicollinearity assessment{p_end}
{phang2}{cmd:. estat vif}{p_end}

{pstd}Multigroup analysis using bootstrap{p_end}
{phang2}{cmd:. plssem (Attractive > face sexy) (Appearance > body appear attract) (Weight > lweight calories cweight), structural(Appearance Attractive, Weight Appearance) group(women, method(bootstrap) reps(500) unequal plot)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse ecsimobi, clear}{p_end}

{pstd}Model estimation{p_end}
{phang2}{cmd:. plssem (Expectation > CUEX1-CUEX3) (Satisfaction > CUSA1-CUSA3) (Complaints > CUSCO) (Loyalty > CUSL1-CUSL3) (Image > IMAG1-IMAG5) (Quality > PERQ1-PERQ7) (Value > PERV1-PERV2), }{p_end}
{p 12 12 2}{cmd: structural(Expectation Image, Quality Expectation, Value Expectation Quality, Satisfaction Value Quality Image Expectation, Complaints Satisfaction, Loyalty Complaints Satisfaction}{p_end}
{p 12 12 2}{cmd: Image) wscheme(path) digits(4) correlate(mv lv cross, cutoff(.3))}{p_end}

{pstd}Inner model graph{p_end}
{phang2}{cmd:. plssemplot, innermodel}{p_end}

{pstd}Outer weights evolution{p_end}
{phang2}{cmd:. plssemplot, outerweights}{p_end}

{pstd}Plot of loadings{p_end}
{phang2}{cmd:. plssemplot, loadings}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. matrix m = (2, 5, 3)}{p_end}
{phang2}{cmd:. matrix sd = (.5, 1, 2)}{p_end}
{phang2}{cmd:. matrix C = (1, .3, 1, .1, .5, 1)}{p_end}
{phang2}{cmd:. drawnorm x1 x2 x3, n(300) means(m) sds(sd) corr(C) cstorage(lower) clear}{p_end}
{p 12 12 2}{cmd: seed(101)}{p_end}

{pstd}Model specification{p_end}
{phang2}{cmd:. matrix M = (1, 0 \ 1, 0 \ 0, 1)}{p_end}
{phang2}{cmd:. matrix rownames M = x1 x2 x3}{p_end}
{phang2}{cmd:. matrix colnames M = y1 y2}{p_end}
{phang2}{cmd:. matrix coleq M = Reflective Formative}{p_end}
{phang2}{cmd:. matrix S = (0, 1 \ 0, 0)}{p_end}
{phang2}{cmd:. matrix rownames S = y1 y2}{p_end}
{phang2}{cmd:. matrix colnames S = y1 y2}{p_end}

{pstd}Model estimation{p_end}
{phang2}{cmd:. plssemmat M, structural(S) wscheme(path) digits(4)}{p_end}

    {hline}


{marker authors}{...}
{title:Authors}

{pstd} Sergio Venturini{break}
Department of Economics and Social Sciences{break}
Università Cattolica del Sacro Cuore, Italy{break}
{browse "mailto:sergio.venturini@unicatt.it":sergio.venturini@unicatt.it}{break}

{pstd} Mehmet Mehmetoglu{break}
Department of Psychology{break}
Norwegian University of Science and Technology{break}
{browse "mailto:mehmetm@svt.ntnu.no":mehmetm@svt.ntnu.no}{break}
{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:plssem} stores the following in {cmd:e()}:

{synoptset 24 tabbed}{...}
{p2col 5 24 28 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(reps)}}number of bootstrap replications{p_end}
{synopt:{cmd:e(n_inadmissibles)}}number of inadmissable bootstrap replications{p_end}
{synopt:{cmd:e(iterations)}}number of iterations to reach convergence{p_end}
{synopt:{cmd:e(tolerance)}}chosen tolerance value{p_end}
{synopt:{cmd:e(maxiter)}}maximum number of iterations allowed{p_end}
{synopt:{cmd:e(converged)}}equal to 1 if convergence is achieved; 0 otherwise{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}

{synoptset 24 tabbed}{...}
{p2col 5 24 28 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:plssem}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(vce)}}type of the variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(mvs)}}list of manifest variables (indicators) used{p_end}
{synopt:{cmd:e(lvs)}}list of latent variables used{p_end}
{synopt:{cmd:e(binarylvs)}}sublist of binary latent variables only{p_end}
{synopt:{cmd:e(datasignaturevars)}}variables used in calculation of checksum {p_end}
{synopt:{cmd:e(datasignature)}}the checksum{p_end}
{synopt:{cmd:e(reflective)}}list of latent variables measured in a reflective way{p_end}
{synopt:{cmd:e(formative)}}list of latent variables measured in a formative way{p_end}
{synopt:{cmd:e(struct_eqs)}}equations defining the structural model{p_end}
{synopt:{cmd:e(properties)}}choices of initialization, weighting scheme, imputation method, 
whether the bootstrap has been used, whether the model has a structural part, whether the
{cmd:rawsum} option has been used, and whether the manifest variables have been scaled or
not{p_end}
{synopt:{cmd:e(robust)}}robust correlation method used{p_end}
{synopt:{cmd:e(ordinal)}}list of indicators treated as ordinal (if any){p_end}

{synoptset 24 tabbed}{...}
{p2col 5 24 28 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(loadings)}}outer loadings matrix{p_end}
{synopt:{cmd:e(loadings_breps)}}outer loadings bootstrap replications (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(loadings_bs)}}bootstrap-based outer loadings matrix (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(loadings_se)}}matrix of the outer loadings standard errors{p_end}
{synopt:{cmd:e(cross_loadings)}}cross loadings matrix{p_end}
{synopt:{cmd:e(cross_loadings_breps)}}cross loadings bootstrap replications (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(cross_loadings_bs)}}bootstrap-based cross loadings matrix (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(cross_loadings_se)}}matrix of the cross loadings standard errors{p_end}
{synopt:{cmd:e(adj_meas)}}adjacency matrix for the measurement (outer) model{p_end}
{synopt:{cmd:e(outerweights)}}matrix of outer weights{p_end}
{synopt:{cmd:e(ow_breps)}}outer weights bootstrap replications (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(ow_bs)}}bootstrap-based outer weights matrix (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(ow_se)}}matrix of the outer weights standard errors (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(ow_history)}}matrix of outer weights evolution{p_end}
{synopt:{cmd:e(relcoef)}}matrix of reliability coefficients{p_end}
{synopt:{cmd:e(sqcorr)}}matrix of squared correlations among the latent variables{p_end}
{synopt:{cmd:e(ave)}}vector of average variances extracted{p_end}
{synopt:{cmd:e(struct_b)}}path coefficients matrix (short form){p_end}
{synopt:{cmd:e(struct_se)}}matrix of path coefficients' standard errors (short form){p_end}
{synopt:{cmd:e(struct_table)}}table combining estimation results for the structural (inner) model{p_end}
{synopt:{cmd:e(pathcoef)}}path coefficients matrix (extended form){p_end}
{synopt:{cmd:e(pathcoef_breps)}}path coefficients bootstrap replications (available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(pathcoef_bs)}}bootstrap-based path coefficients matrix (extended form; available only
if the {cmd:boot()} option is chosen){p_end}
{synopt:{cmd:e(adj_struct)}}adjacency matrix for the structural (inner) model{p_end}
{synopt:{cmd:e(total_effects)}}matrix of the structural (inner) model total effects{p_end}
{synopt:{cmd:e(rsquared)}}vector of r-squared for reflective latent variables{p_end}
{synopt:{cmd:e(redundancy)}}vector of redundancies{p_end}
{synopt:{cmd:e(assessment)}}vector of model quality indices{p_end}
{synopt:{cmd:e(reldiff)}}vector containing the history of weights' relative differences{p_end}
{synopt:{cmd:e(imputed_data)}}matrix of imputed indicators; available only if the
the {cmd:missing} option has been used{p_end}
{synopt:{cmd:e(R)}}latent variable correlation matrix{p_end}
{synopt:{cmd:e(ind_vcv)}}indicators' variance-covariance matrix{p_end}
{synopt:{cmd:e(proxy_vcv)}}proxies' variance-covariance matrix{p_end}
{synopt:{cmd:e(construct_vcv)}}constructs' variance-covariance matrix{p_end}
{synopt:{cmd:e(resid_corr)}}residuals' correlation matrix{p_end}
{synopt:{cmd:e(struct_vif)}}inner model's variance inflation factors{p_end}
{synopt:{cmd:e(reliabilities)}}construct reliabilities{p_end}

{synoptset 24 tabbed}{...}
{p2col 5 24 28 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References} 

{marker BaronKenny1986}{...}
{phang}
Baron, R. M., and Kenny, D. A. 1986. The Moderator-Mediator Variable Distinction in Social Psychological
Research: Conceptual, Strategic, and Statistical Considerations. Journal of
Personality and Social Psychology, 51, 1173-1182.

{marker CantaluppiBoari2016}{...}
{phang}
Cantaluppi, G., and Boari, G. 2016. A Partial Least Squares Algorithm Handling Ordinal Variables. In Abdi, H., Esposito Vinzi, V., Russolillo, G., Saporta, G. and Trinchera, L. (Eds.), {it:The Multiple Facets of Partial Least Squares and Related Methods}, (pp. 295-306). Springer.

{marker Hairetal2022}{...}
{phang}
Hair, J. F., Hult, G. T. M., Ringle, C. M., and Sarstedt, M. 2022. {it:A Primer on Partial Least Squares Structural Equation Modeling (PLS-SEM)}. Third edition. Sage.

{marker Lohmoller1989}{...}
{phang}
Lohmöller, J. B. 1989. {it:Latent Variable Path Modeling with Partial Least Squares}. Heidelberg: Physica.

{marker MehmetogluVenturini2021}{...}
{phang}
Mehmetoglu, M., and Venturini, S. 2021. {it:Structural Equation Modelling with Partial Least Squares Using Stata and R}. CRC Press.

{marker RousseeuwvanDriessen1999}{...}
{phang}
Rousseeuw, P. J. and van Driessen, K. 1999. A Fast Algorithm For The Minimum Covariance Determinant Estimator. Technometrics, 41, 212–223.

{marker Schambergeretal2020}{...}
{phang}
Schamberger, T., Schuberth, F., Henseler, J., and Dijkstra, T. K. 2020. Robust Partial Least Squares Path Modeling. Behaviormetrika, 47, 1, 307–334.

{marker Sobel1982}{...}
{phang}
Sobel, M. N. 1982. Asymptotic Confidence Intervals for Indirect Effects in Structural Equations
Models. In Leinhart, S. (ed.), {it:Sociological Methodology}, pp. 290-312. Jossey-Bass.

{marker VanderWeele2015}{...}
{phang}
VanderWeele, T. J. 2015. {it:Explanation in Causal Inference}. Oxford University Press.

{marker Wold1975}{...}
{phang}
Wold, H. O. A. 1975. Path Models with Latent Variables: The NIPALS Approach.
In Blalock, H. M., Aganbegian, A., Borodkin, F. M., Boudon, R., and Cappecchi, V. (ed.), {it:Quantitative Sociology} (pp. 307-359). New York: Academic Press.
{p_end}
