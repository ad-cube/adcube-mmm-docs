#


## MMMClient
```python 
MMMClient()
```


---
Client implementation for interacting with AD cube's Marketing Mix
Model APIs


**Methods:**


### .load_data
```python
.load_data(
   experiment_name: str, dataset: pd.DataFrame, platforms: List[str],
   awareness: List[bool], impression_kpi: str, target_kpi: str,
   offline_platforms: List[str], extra_features: List[str], use_data_quality: bool
)
```

---
Loads the dataset and all the variables needed for executing the
Marketing Mix Model.

Parameters
----------
experiment_name
Name of the experiment. Needed to save the results
---
dataset
    DataFrame containing the data for the Marketing Mix Model.
    The index must be in the form Year-Week; moreover it must
    contain the cost, impressions and conversions columns for
    each platform specified in `platforms`
platforms
    List of advertising platform names, for example:
    ['Google paid search', 'TikTok', 'Google search']. They must
    be substring of the cost, impressions and conversions
    columns' names, for example 'Cost_TikTok'.
awareness
    List of boolean representing whether the corresponding
    platform in `platforms` is an awareness platform, for
    example: [False, True, False]
impression_kpi
    Prefix of the impressions columns, for example 'impressions'
    means that the columns containing impressions are names as
    'impressions_<PLATFORM NAME>' where PLATFORM NAME is one of
    `platforms`
target_kpi
    Complete name of the target KPI column, for example
    'Total conversions'. Analogously to impression_kpi, it is
    also the prefix of the target KPI columns for each platform
offline_platforms
    'radio']
extra_features
    'promotions']
use_data_quality
    Boolean representing whether the user provided a
    `data_quality` column in `dataset`

Returns
-------
data_id
    Id of the Marketing Mix Model data saved in DB

Raises
------
MalformedDatasetException
    If the dataset does not follow the correct schema

### .fit
```python
.fit(
   data_id: str, experiment_name: str
)
```

---
Fits the AI model using the data previously loaded. This method
must be called before the 'optimize_data'.

Parameters
----------
experiment_name
Name of the experiment. Needed to save the results
---
data_id
    Id of the Marketing Mix Model data saved in DB, returned
    from load_data(). It is needed to load the model's data

Returns
-------
model_id
    ID of the fitted AI model saved in DB

### .optimize
```python
.optimize(
   date_range: Tuple[str, str], trgt_mult: float, model_id: str, data_id: str,
   experiment_name: str
)
```

---
Run this method in order to obtain the optimal budget for all
weeks and all platforms in the weeks specified in `date_range`.
Specify `date_range` as a tuple of strings (start, end) with the
format 'YYYY-WW'. These values specify for which weeks the user
wants to optimize the budget. The year value is used to
determine which past data use as reference for the budget
allocation.
The `trgt_mult` parameter specifies the budget multiplier, so a
value of '1.2' will optimize the 120% of the past budget
allocation.
`model_id` and `data_id` are the ids of the AI model and the
data respectively.

For example, if the user wants to optimize the budget for the
last quarter of the year, using (as a reference) the same budget
of 2022, then:
- `data_range` = ['2022-40', '2022-52']
- `trgt_mult` = 1.

Parameters
----------
experiment_name
Name of the experiment. Needed to save the results
---
    the selected period.
    a reliable forecasting.
model_id
    Id of the model obtained when running the fit() method. It
    is needed to load the fitted models
data_id
    Id of the data obtained when running the load_data() method.
    It is needed to load the model's data

### .create_plots
```python
.create_plots(
   product_name: str, company_name: str, model_id: str, data_id: str,
   opt_results_id: str
)
```

---
Creates some interesting plots containing the Marketing Mix
Model optimization results

Parameters
----------
product_name
Name of the product
---
company_name
    Name of the company
model_id
    Id of the fitted model
data_id
    Id of the data to use
opt_results_id
    Id of the optimization results

Returns
-------
plots
    A zip file containing plots

### .create_excel
```python
.create_excel(
   excel_name: str, model_id: str, data_id: str, opt_results_id: str
)
```

---
Creates an Excel containing the Marketing Mix Model optimization results

Parameters
----------
excel_name
Name of the output Excel
---
model_id
    ID of the fitted model
data_id
    ID of the data to use
opt_results_id
    ID of the optimization results

Returns
-------
plots
    An Excel file

### .get_experiments_list
```python
.get_experiments_list()
```

---
Returns the list of the user's experiments

Returns
-------
experiments
A list of UserExperiment objects, containing the data
about all the user's experiments

### .get_experiment
```python
.get_experiment(
   experiment_name: str
)
```

---
Returns the experiment named `experiment_name`, if it exists

Parameters
----------
experiment_name
Name of the experiment to be found

---
Returns
-------
experiment
    UserExperiment object, containing the data of the experiment

### .create_experiment
```python
.create_experiment(
   experiment_name: str
)
```

---
Creates a new experiment for the user. The experiment will
contain all the data about the Marketing Mix Model data, models
and optimization results.

Parameters
----------
experiment_name
Name of the experiment. Must be unique among the user's
experiments
