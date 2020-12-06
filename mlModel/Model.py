#!/usr/bin/env python3# -*- coding: utf-8 -*-"""Created on Sat Dec  5 14:09:38 2020@author: wzy"""import numpy as npimport osimport torchfrom time import timefrom torch import nnfrom torch.optim import Adamfrom torch.utils.data import DataLoader, Datasetfrom torch.utils.data.sampler import SubsetRandomSamplerfrom torch.autograd import Variableimport matplotlib.pyplot as pltimport tqdmimport pandas as pdfrom sklearn.preprocessing import StandardScalerclass XeniaData(Dataset):    def __init__(self, raw_dat):        dat = np.asarray(raw_dat)        self.inp = torch.from_numpy(dat[:, 1:7]).float()        self.oup = torch.from_numpy(dat[:, 7:8]).float()        self.samples = dat.shape[0]    def __getitem__(self, index):        return self.inp[index], self.oup[index]        def __len__(self):        return self.samplesclass XeniaNet(nn.Module):    def __init__(self, input_size, hidden_size):        super().__init__()        self.fc1 = nn.Linear(input_size, hidden_size)        self.b1 = nn.ReLU()        self.fc2 = nn.Linear(hidden_size, hidden_size)        self.b2 = nn.ReLU()        self.fc3 = nn.Linear(hidden_size, hidden_size)        self.b3 = nn.ReLU()        self.fc4 = nn.Linear(hidden_size, 1)    def forward(self,x):        ex = self.fc1(x)        ex = self.b1(ex)        ex = self.fc2(ex)        ex = self.b2(ex)        ex = self.fc3(ex)        ex = self.b3(ex)        ex = self.fc4(ex)        return exdef splitData(data_set, test_split=0.2):    dataset_size = data_set.samples    indices = list(range(dataset_size))    dataset_size = len(data_set)    indices = list(range(dataset_size))    np.random.shuffle(indices)    split = int(np.floor(test_split * dataset_size))    train_indices, test_indices = indices[split:], indices[:split]    return train_indices, test_indicesdef predict(loader, net):  for features, labels in loader:      features = Variable(features.view(-1, 6))      outputs = net(features)      print(outputs)  return outputsdef composeModel(raw_data):    data_set = XeniaData(raw_data) #subject to change    batch_size = 1    test_split = 0.0    train_indices, test_indices = splitData(data_set, test_split)    train_sampler = SubsetRandomSampler(train_indices)    test_sampler = SubsetRandomSampler(test_indices)    train_loader = torch.utils.data.DataLoader(data_set, batch_size = batch_size, sampler = train_sampler)    test_loader = torch.utils.data.DataLoader(data_set, batch_size = batch_size, sampler = test_sampler)        xeniaNet = XeniaNet(input_size = 6, hidden_size = 10)    criterion = nn.MSELoss()    EPOCHS = 10    optimizer = Adam(xeniaNet.parameters(), lr = 0.0008)        loss_tracker = []    for epoch in range(EPOCHS):      loss = 1      progress_bar = tqdm.notebook.tqdm(train_loader, ncols=1000)      for i, (features, labels) in enumerate(progress_bar):        x_train = Variable(features.view(-1, 6))        labels = Variable(labels)        optimizer.zero_grad()        outputs = xeniaNet(x_train.float())        loss = criterion(outputs, labels)        loss.backward()        optimizer.step()        loss_tracker.append(loss.data)                                              if (i+1) % 100 == 0 or (i+1) == len(train_loader):             progress_bar.set_description('Epoch [%d/%d], Step [%d/%d], Val, Training Loss: %.4f'                  %(epoch+1, EPOCHS, i+1, len(train_loader), loss.data))    torch.save(xeniaNet, "Params")