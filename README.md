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
2022. ISSN 1746-8094. doi: https://doi.org/10.1016/j.bspc.2022.103895. URL
https://www.sciencedirect.com/science/article/pii/S1746809422004050.

