# 8类
from sklearn.neighbors import KNeighborsClassifier
import scipy.io as scio
from scipy.io import savemat
from sklearn import metrics
import numpy as np
from sklearn.preprocessing import StandardScaler
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

# std = StandardScaler()
# x_train = std.fit_transform(x_train)
# x_test = std.transform(x_test)

# x_train, x1_test, y_train, y1_test = train_test_split(x_train, y_train, test_size=0.1,random_state=0)
knn = KNeighborsClassifier(n_neighbors=1,algorithm='auto') # 创建一个KNN算法实例，n_neighbors默认为5,后续通过网格搜索获取最优参数
knn.fit(x_train, y_train) # 将测试集送入算法
y_predict = knn.predict(x_test) # 获取预测结果
ov_acc = metrics.accuracy_score(y_predict,y_test)
print("overall accuracy: %f"%(ov_acc))
print("===========================================")
acc_for_each_class = metrics.precision_score(y_test,y_predict,average=None)
print("acc_for_each_class:\n",acc_for_each_class)
print("===========================================")
avg_acc = np.mean(acc_for_each_class)
print("average accuracy:%f"%(avg_acc))

y_pred = []
for i in range(lenxtest):
    if y_testold[i][0] == 0:
        y_pred.append(0)
    else:
        y_pred.append(knn.predict(x_testold[i].reshape(1,-1))[0])

# y_predict = y_predict.reshape(145, 145)
savemat('newData.mat', {'y_pred': y_pred})
print(knn.score(x_test, y_test))
print(knn.score(x_train, y_train))