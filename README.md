# Estimation of Blood Pressure Waveform from Facial Video

This repository contains the implementation and results of a research project aimed at estimating continuous blood pressure (BP) waveforms from facial video data. The work is based on the paper titled "Estimation of Blood Pressure Waveform from Facial Video Using a Deep U-shaped Network and the Wavelet Representation of Imaging Photoplethysmographic Signals" and was conducted as part of my project Thesis.

## Introduction

The remote measurement of physiological signals from video has gained significant attention in recent years. However, estimating cardiovascular parameters such as oxygen saturation and arterial blood pressure (BP) from facial video remains a challenging issue, often limited by data availability and controlled scenarios.

### Research Objectives

- Develop a framework for estimating BP from publicly available imaging photoplethysmographic (iPPG) data.
- Enable replication of the methodology for fair comparison and benchmarking.
- Train a deep U-shaped neural network to recover BP waveforms from iPPG signals.
- Evaluate the framework against international standards for BP estimation.

## Methodology

### Data

We utilized publicly available data to ensure transparency and replicability BP4D+. This dataset includes facial video recordings and bp values.

### Model Architecture

Designed a deep U-shaped neural network to predict the continuous wavelet transform (CWT) representation of BP signals from iPPG data. The inverse CWT transform was employed to recover BP time series.

## Results

The proposed framework was rigorously evaluated using standards developed by the Association for the Advancement of Medical Instrumentation (AAMI) and the British Hypertension Society (BHS). The results demonstrated:

- Close agreement with ground truth BP values.
- Satisfaction of all standards for mean and diastolic BP estimation (grade A).
- Fulfillment of nearly all standards for systolic BP estimation (grade B).


## Citation

If you find this research helpful and utilize it in your work, please consider citing the original paper:

Frédéric Bousefsaf, Théo Desquins, Djamaleddine Djeldjli, Yassine Ouzar, Choubeila
Maaoui, and Alain Pruski. Estimation of blood pressure waveform from facial video
using a deep u-shaped network and the wavelet representation of imaging photoplethysmographic signals. Biomedical Signal Processing and Control, 78:103895,
2022. ISSN 1746-8094. DOI: https://doi.org/10.1016/j.bspc.2022.103895
URL: https://www.sciencedirect.com/science/article/pii/S1746809422004050

# Running the Blood Pressure Estimation Code

Follow these steps to run the code for blood pressure estimation:

## Step 1: Pre-processing

### 1.1 PPg Signal Extraction
- Run the following Python scripts for PPg signal extraction:
  - `python image_processing.py`
  - `python signal_processing.py`
  - `python ippg_lightness_segmentation.py`

## Step 2: Data Conversion

### 2.1 MAT to CSV Conversion
- Convert the generated MAT files to CSV format using the following command: python Mat_to_csv.py
 This will create a `merged_file` in the `ippg_lightness_segmentation` directory.

## Step 3: Data Location

### 3.1 Data Location
- The iPPG and BP values can be found at the following directory: where you saved
 
## Step 4: Data Plotting

### 4.1 Transparency Value Plotting
- Plot the transparency value for SBP, MAP, and DBP using the script `testing_plot.py`. This script can be found in your directory you mentioned.


## Step 5: MATLAB Processing

### 5.1 MATLAB Processing
- In MATLAB, run the script `cwt_bp_ippg_update.m`. This script will generate `cwt_bp_updated` and `cwt_ippg_updated` signals.

## Step 6: Data Integration

### 6.1 Data Integration
- Combine `cwt` and `cwt_bp` into a single MAT file using the following command or through the MATLAB interface:
 save('cwt_signals.mat', 'cwt_ippg_updated', 'cwt_bp_updated', '-v7.3');


## Step 7: Dataset Splitting

### 7.1 Dataset Splitting
- Run the `splitting_dataset.m` script to generate training, testing, and validation MAT files separately.

## Step 8: Data Preparation

### 8.1 Data Preparation
- Concatenate the cells in the training MAT file using the following MATLAB commands:
train_bp = {cat(2, training_data_bp{:})};
train_bp = train_bp{1};

Save the following MAT files:
- `training_bp_ippg.mat` (train and validation data)
- `testing_bp_ippg.mat` (testing data)

## Step 9: Neural Network Training

### 9.1 Neural Network Training
- Pass the MAT files generated in the previous step to the neural network code. Run the following Python script for training the network: python train.py


## Step 10: Analysis

### 10.1 Analysis
- Run the MATLAB scripts for analysis and evaluation:
 - `maincode.m`
 - `sbp_dbp_map_plots.m` (for SBP, MAP, and DBP prediction error)
 - `Bhs_standard.m` (for BHS standards)
 - `Aami_standard.m` (for AAMI standards)


