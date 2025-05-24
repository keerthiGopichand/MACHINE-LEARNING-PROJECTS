
# credit card model predication 
Key findings: People with the highest income, and who have at least one partner, are more likely to be approved for a credit card.

## problem statement 
This app predicts if an applicant will be approved for a credit card or not. Each time there is a hard enquiry your credit score is affected negatively. This app predict the probability of being approved without affecting your credit score. This app can be used by applicant who wants to find out if they will be approved for a credit card without affecting their credit score.

## Methods 
- Exploratory data analysis
- Bivariate analysis
- Multivarate correlation
- S3 bucket model hosting
- Model deployment



## Tech Stack

Python (refer to requirement.txt for the packages used in this project)
Streamlit (interface for the model)
AWS S3 (model storage)

## Quick glance at the results
- Correlation between the features.
- Confusion matrix of gradrient boosting classifier.
- ROC curve of gradrient boosting classifier.

Model	     and            Recall score
Support vector machine	    88%,
Gradient boosting	        90%,
Adaboost	                79%

- The final model used is: Gradient boosting

- Metrics used: Recall

- Why choose precision as metrics: Since the objective of this problem is to minimize the risk of credit default for the financial institution, the metrics to use depends on the current economical situation:

- During the time of a bull market (when the economy is expending), people feel wealthy and usually are employed. Money is usually cheap and the risk of default is low. The financial institution is able to handle the risk of default therefore is not very strict on giving out credit. The financial institution can handle a number of bad clients as long as the vast majority of applicants are good clients (aka those who payback their credit).In this case, having a good recall (sensitivity) is ideal.

- During a bear market (when the economy is contracting), people loose their jobs and their money through the stock market. Many people struggle to meet their financial obligations. The financial institution therefore tend to be more conservative on giving out credit or loans. The financial institution can't afford to give out credit to clients who won't be able to pay back their credit. The financial institution would rather have a smaller number of good clients even if it means that some good clients where denied credit, and ideally not have any bad client. In this case, having a good precision (specificity) is desirable.

Note: There is always a trade-off between precision and recall. Choosing the right metrics depends on the problem you are solving.

Conclusion: In our case, since we are in the longest bull market (not including the March 2024 flash crash), we will use recall as our metric.

