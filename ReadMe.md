Project Workflow to analyze the variables that go into customers accepting the credit card offer.

1. We loaded our datasets into MYSQL to create and organzie our database as well as begin exploring our data in MYSQL
2. We then imported out credit rating database into a jupyter notebook doument to begin running a model to predict positive and negative responses to the credit card offer.
3. We first just quickly tansformed out categorical data to numerical and ran the logistic regression model to give us initial results to improve on.
4. We were unstatisifed with the results of the logistic regression model  so we added the models AdaBoostClassifier, RandomForestClassifier, KNeighborsClassifier, and Support VectorClassifier.
5. We then loaded our dataframe into Tableau to begin exploring the relationship between the data of who accepted the credit card and who declined.
6. We extrapilated from our research in Tabluea that the most influential features in determing whether someone declined or rejected the credit card request was their income level, their credit rating , the type of rewards they were offered and the mailing type used to deliver the offer. 
7.  We then also began exploring the relevance of our features via the correllation matrix the Chi2 test and through feature inportance.
8. We then took that information back to our python models and began adjusting our features to try to improve the predictions of our models. The processes we used were trying different categories an different methods to improve the distribution of our features.
