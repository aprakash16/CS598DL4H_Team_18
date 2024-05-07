# CS 598 DLH Final Project - Team 18

## Introduction

The study is based on the paper Barbieri, S., Kemp, J., Perez-Concha, O. et al. “Benchmarking Deep Learning Architectures for Predicting Readmission to the ICU and Describing Patients-at-Risk”, Sci Rep 10, 1111 (2020) https://doi.org/10.1038/s41598-020-58053-z. The original authors have provided the code [here] (https://github.com/sebbarb/time_aware_attention/tree/master). We will use the existing code of the original authors so that, there are minimum side effects. Our plan includes to add two ablations mentioned in Scope of Reproducibility section.

If you want to find out more about our reproduction study, please checkout the following:
1. Presentation: 
2. Final Report: 

# Scope of Reproducibility

The following hypotheses will be tested:

1. Hypothesis 1: Recurrent models outperform models that only use attention layers by a small margin.
2. Hypothesis 2: Adding attention layers to deep neural networks may improve the model's interpretability but does not degrade average precision.


Following ablations have been implemented in order to observe the impact of eliminating timestamped code from model's embeddings:

1. RNN: Embeddings are passed into RNN layers directly.
2. RNN + Attention: Embeddings are provided to RNN layers, followed by the application of attention to the RNN outputs

## Environment

Python 3.x has been used. The list of dependencies/packages can be found [here](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/requirements.txt).
```
$ pip3 install -r related_code/requirements.txt
```

If you wish to reproduce this in the local isolated environment you can use this [Dockerfile] (https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/Dockerfile).
```
# Building the container image
$ docker build . -f Dockerfile -t cs598-dl4h-finalproject-env

# Running the image and mount this repository into /workspace directory
$ docker run -v <repo>:/workspace -it cs598-dl4h-finalproject-env
root@...# cd /workspace
```

## Data

[MIMIC-III Clinical Database 1.4](https://physionet.org/content/mimiciii/1.4/) will be used. It is available in [PhysioNet](https://physionet.org/). For accessing the data, a request needs to be raised. Once the data is available, place the datasets in "mimic-iii-clinical-database-1.4" folder at the root of the repository. Please note, you will need to unzip those files as most of them would be downloaded in .gz file format. Due to health data license and privacy concern, this dataset has not been directly placed in the public repository.

## Preprocessing

Please refer to https://github.com/aprakash16/CS598DL4H_Team_18/tree/main/related_code. The following data pre-processing code can be found in 'related_code' folder in Github repository:
1. [1_preprocessing_ICU_PAT_ADMIT.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/1_preprocessing_ICU_PAT_ADMIT.py)
2. [2_preprocessing_reduce_charts.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/2_preprocessing_reduce_charts.py)
3. [3_preprocessing_reduce_outputs.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/3_preprocessing_reduce_outputs.py)
4. [4_preprocessing_merge_charts_outputs.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/4_preprocessing_merge_charts_outputs.py)
5. [5_preprocessing_CHARTS_PRESCRIPTIONS.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/5_preprocessing_CHARTS_PRESCRIPTIONS.py)
6. [6_preprocessing_DIAGNOSES_PROCEDURES.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/6_preprocessing_DIAGNOSES_PROCEDURES.py)
7. [7_preprocessing_create_arrays.py](https://github.com/aprakash16/CS598DL4H_Team_18/blob/main/related_code/7_preprocessing_create_arrays.py)

Once, you have unzipped the MIMIC-III datasets and placed them in "mimic-iii-clinical-database-1.4", open shell in the root folder and execute the following commands for pre-processing the data.

```
# Run pre-processing scripts
$ python3 related_code/1_preprocessing_ICU_PAT_ADMIT.py
$ python3 related_code/2_preprocessing_reduce_charts.py
$ python3 related_code/3_preprocessing_reduce_outputs.py
$ python3 related_code/4_preprocessing_merge_charts_outputs.py
$ python3 related_code/5_preprocessing_CHARTS_PRESCRIPTIONS.py
$ python3 related_code/6_preprocessing_DIAGNOSES_PROCEDURES.py
$ python3 related_code/7_preprocessing_create_arrays.py
```
## Training

To train the model run the following commands:
```
# Training the model
$ ./train_model.sh
1) ODE + RNN + Attention       3) *ABLATION* RNN
2) *ABLATION* RNN + Attention  4) QUIT
Which model do you want to train? 1
====================================
Training ODE + RNN + Attention (ode_birnn_attention) ...
====================================
Load data...
-----------------------------------------
```

## Evaluation

To evaluate the model, run the following command:
```
# Evaluating the model
$ ./eval_model.sh
1) ODE + RNN + Attention       3) *ABLATION* RNN
2) *ABLATION* RNN + Attention  4) QUIT
Which model do you want to evaluate? 1
====================================
Evaluating ODE + RNN + Attention (ode_birnn_attention) ...
====================================
Load data...
```
## Result

We were able to reproduce the ODE+RNN+Attention model (using full version of MIMIC-III dataset) and got results similar to the orignal paper with the following results on local setup:

Average Precision: 0.311 [0.304,0.319]
AUROC (Area Under the Receiver Operating Characteristic Curve):	0.74 [0.738,0.743]
F1 Score: 0.363 [0.358,0.368]
PPV (Positive Predictive Value): 0.983 [0.967,1.0]
NPV (Negative Predictive Value): 0.882 [0.881,0.884]
Sensitivity: 0.719 [0.711,0.728]
Specificity: 0.66 [0.652,0.669]
