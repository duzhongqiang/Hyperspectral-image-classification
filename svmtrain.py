#8类
from sklearn import svm
import scipy.io as scio
from sklearn import metrics
import numpy as np
from scipy.io import savemat
from sklearn.model_selection import train_test_split


Data  = scio.loadmat('Data.mat')
x_train = Data['DataTrain']
y_train = Data['LabelTrain']
x_testold = Data['finalimg']
y_testold = Data['labelimg']

x_test = []
y_test = []
lenxtest = y_testold.shape[0]
for i in range(lenxtest):
    if y_testold[i][0] != 0:
        y_test.append(y_testold[i][0])
        x_test.append(x_testold[i])
 



# 训练模型
clf = svm.SVC(C=5, kernel='rbf', gamma=0.0002, decision_function_shape='ovo')
clf.fit(x_train, y_train.ravel())

print('train accuracy:',clf.score(x_train, y_train))
print('test accuracy:',clf.score(x_test, y_test))
y_test_pred = clf.predict(x_test)

acc_for_each_class = metrics.precision_score(y_test,y_test_pred,average=None)
print("acc_for_each_class:\n",acc_for_each_class)
print("===========================================")
avg_acc = np.mean(acc_for_each_class)
print("average accuracy:%f"%(avg_acc))


y_pred = []
for i in range(lenxtest):
    if y_testold[i][0] == 0:
        y_pred.append(0)
    else:
        y_pred.append(clf.predict(x_testold[i].reshape(1,-1))[0])

savemat('newData.mat', {'y_pred': y_pred})


