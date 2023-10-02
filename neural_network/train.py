import numpy as np
import tensorflow as tf
import scipy.io
import sklearn
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as mp

from tensorflow.python.keras.models import Model
from tensorflow.python.keras.layers import Input, Conv2D
from tensorflow.python.keras.callbacks import ModelCheckpoint
from tensorflow.keras.callbacks import CSVLogger
from tensorflow.keras.optimizers import Adam

from keras import backend as K
from keras import activations, initializers, regularizers, constraints, metrics
from keras.datasets import cifar10
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential, Model
from keras.layers import (Dense, Dropout, Activation, Flatten, Reshape, Layer,
                          BatchNormalization, LocallyConnected2D,
                          ZeroPadding2D, Conv2D, MaxPooling2D, Conv2DTranspose,
                          GaussianNoise, UpSampling2D, Input)
from keras.layers import Lambda

import segmentation_models as sm
from segmentation_models.models.unet import Unet        

# GLOBAL VARIABLES
BACKBONE = 'resnext101' # 'vgg16', 'vgg19', 'resnet101', 'seresnet101', 'resnext101', 'seresnext101', 'inceptionresnetv2', 'inceptionv3', 'densenet201'
FREEZE_ENCODER = False
VERBOSE = 2
EPOCHS = 2
BATCH_SIZE = 16


# LOAD TRAINING DATA
data_training = scipy.io.loadmat('D:\\Documents\\FH-Dortmund\\Mini Project thesis\\ippg_to_bp\\training_bp_ippg.mat')
xtrain = np.zeros((data_training['train_ippg'].shape[1], data_training['train_ippg'][0,0]['cfs'][0,0].shape[0], data_training['train_ippg'][0,0]['cfs'][0,0].shape[1],2))
ytrain = np.zeros((data_training['train_bp'].shape[1], data_training['train_bp'][0,0]['cfs'][0,0].shape[0], data_training['train_bp'][0,0]['cfs'][0,0].shape[1],2))

for i in range(data_training['train_ippg'].shape[1]):
    xtrain[i,:,:,0] = np.real(data_training['train_ippg'][0,i]['cfs'][0,0])
    xtrain[i,:,:,1] = np.imag(data_training['train_ippg'][0,i]['cfs'][0,0])
    ytrain[i,:,:,0] = np.real(data_training['train_bp'][0,i]['cfs'][0,0])
    ytrain[i,:,:,1] = np.imag(data_training['train_bp'][0,i]['cfs'][0,0])


# LOAD VALIDATION DATA
xvalid = np.zeros((data_training['valid_ippg'].shape[1], data_training['valid_ippg'][0,0]['cfs'][0,0].shape[0], data_training['valid_ippg'][0,0]['cfs'][0,0].shape[1],2))
yvalid = np.zeros((data_training['valid_bp'].shape[1], data_training['valid_bp'][0,0]['cfs'][0,0].shape[0], data_training['valid_bp'][0,0]['cfs'][0,0].shape[1],2))

for i in range(data_training['valid_ippg'].shape[1]):
    xvalid[i,:,:,0] = np.real(data_training['valid_ippg'][0,i]['cfs'][0,0])
    xvalid[i,:,:,1] = np.imag(data_training['valid_ippg'][0,i]['cfs'][0,0])
    yvalid[i,:,:,0] = np.real(data_training['valid_bp'][0,i]['cfs'][0,0])
    yvalid[i,:,:,1] = np.imag(data_training['valid_bp'][0,i]['cfs'][0,0])



# DEFINE AND TRAIN MODEL
model = sm.Unet(BACKBONE, classes=xtrain.shape[3], encoder_weights='imagenet', encoder_freeze=FREEZE_ENCODER, activation=None)

# Channel adaptation
inp = Input(shape=(None, None, xtrain.shape[-1]))
l1 = Conv2D(3, (1, 1))(inp) # map N channels data to 3 channels
out = model(l1)
model = Model(inp, out, name=model.name)

model_checkpoint = ModelCheckpoint('D:/Documents/FH-Dortmund/Mini Project thesis/ippg2bp-main/ippg2bp-main/weights.h5', monitor='val_loss', save_best_only=True, mode='auto')  
history_checkpoint = CSVLogger('history.csv', append=False)

model.compile(optimizer=Adam(learning_rate=1e-3), loss='mean_squared_error', metrics=['mean_absolute_error'])
model.summary()

model_json = model.to_json()
with open('D:/Documents/FH-Dortmund/Mini Project thesis/ippg2bp-main/ippg2bp-main/model.json', 'w') as json_file:
    json_file.write(model_json)


history = model.fit(xtrain, ytrain, batch_size=BATCH_SIZE, epochs=EPOCHS, validation_data=(xvalid, yvalid), callbacks=[model_checkpoint, history_checkpoint], verbose=VERBOSE)
print(history)

#Prediction
# LOAD TRAINING DATA
data_testing = scipy.io.loadmat('D:\\Documents\\FH-Dortmund\\Mini Project thesis\\ippg_to_bp\\testing_bp_ippg.mat')
ppg_test = np.zeros((data_testing['testing_ippg'].shape[1], data_testing['testing_ippg'][0,0]['cfs'][0,0].shape[0], data_testing['testing_ippg'][0,0]['cfs'][0,0].shape[1],2))
bp_test = np.zeros((data_testing['testing_bp'].shape[1], data_testing['testing_bp'][0,0]['cfs'][0,0].shape[0], data_testing['testing_bp'][0,0]['cfs'][0,0].shape[1],2))

for i in range(data_testing['testing_ippg'].shape[1]):
    ppg_test[i,:,:,0] = np.real(data_testing['testing_ippg'][0,i]['cfs'][0,0])
    ppg_test[i,:,:,1] = np.imag(data_testing['testing_ippg'][0,i]['cfs'][0,0])
    bp_test[i,:,:,0] = np.real(data_testing['testing_bp'][0,i]['cfs'][0,0])
    bp_test[i,:,:,1] = np.imag(data_testing['testing_bp'][0,i]['cfs'][0,0])


results = np.zeros((bp_test.shape[0]), dtype=np.object)

for i in range(bp_test.shape[0]):
    pred = model.predict(np.expand_dims(ppg_test[i],0))
    results[i] = {}
    results[i]['prediction'] = pred[0]
scipy.io.savemat('D:\\Documents\\FH-Dortmund\\Mini Project thesis\\ippg_to_bp\\results.mat',{'results':results})