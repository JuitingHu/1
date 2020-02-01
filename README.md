# The attrition of Shanghai Ctrip call centre
 
This project uses Ctrip WFH(working from home) data which is asked by the lecturer of Experiments for Business Analytics. It is collected from WFH experiment in Ctrip’s Shanghai call center from 2010 to 2011. 

Due to the significantly higher turnover rate in Ctrip’s Shanghai call center than in other industries, the purpose of the project which I set is to help Ctrip’s human resource department to reduce the high attrition rate and prevent employee turnover when they recruit new staffs. 

For the recruiter, obtaining personal information about age and children are quite easier than performance, satisfaction and so on. Therefore, the research would explore the effect of age and children on the relationship between attrition in Shanghai Ctrip call centre.

The hypothetical relationship between age, children and attrition are created as below.

Hypothesis 1: Younger employees have higher turnover intentions than older employees.
               
              Attrition= αAge + γMarried + εMen

Hypothesis 2: Employees who have children have higher turnover intentions than those who do not have.

              Attrition= βChildren + γMarried+ εMen

Hypothesis 3: Employees who are younger and have children are most likely to quit the job.
              
              Attrition= αAge + βChildren + γMarriedgender + εMen

The regression models and marginal effects are built and calculated to find the result of the research.

Firstly, trying to run the OLS , however, since the binary dependent variable, results of model are not as expected. The probabilities cannot be less than 0 or greater than 1. Therefore, three models are re-established by running the logistic regression. Through this function, the output will become any real values betweeen 0 and 1.

Secondly, the average marginal effects (AME) and P-value which are calculated are referred to as the results of three hypothesis.

For R code for this research, please see scripts "RCode.R".
Further detailed information on this research is available in "Essay_The attrition of Shanghai Ctrip call centre.pdf".

