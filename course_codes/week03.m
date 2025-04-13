%% 改善
% 标准化、归一化
% 对数
% 共线性
% 非线性关系

%% 数据清洗
% 填补缺失值
% area 用移动中位数填补（窗口大小为 10）
data = readtable('house_price_data.xlsx');
data.area = fillmissing(data.area, 'movmedian', 10);
% house_age 用中位数填补
house_age_median = median(data.house_age, 'omitnan'); % 计算中位数
data.house_age = fillmissing(data.house_age, 'constant', house_age_median);
% district 用 0 填补
data.district = fillmissing(data.district, 'constant', 0);
% 处理异常值
% area 用 99 分位数判断
area_q99 = prctile(data.area, 99); % 计算 99 分位数
data.area(data.area > area_q99) = area_q99; % 将大于 99 分位数的值替换为 99 分位数
% price 用 99 分位数判断
price_q99 = prctile(data.price, 99); % 计算 99 分位数
data.price(data.price > price_q99) = price_q99; % 将大于 99 分位数的值替换为 99 分位数
% house_age 不能为负数
data.house_age(data.house_age < 0) = house_age_median; % 将负数替换为中位数
% price 不能为负数
data.price(data.price < 0) = price_q99; % 将负数替换为 99 分位数
% 删除重复行
data = unique(data);

%% 特征工程
% 非线性项: 先平方再标准化
data.area_sq = data.area.^2;
data.area = zscore(data.area);
data.area_sq = zscore(data.area_sq);
% 分类变量编码 (district)
district_cat = categorical(data.district, [0,1,2,3], {'Missing','Suburb','Urban','School'});
dummyVars = dummyvar(district_cat);
cols = size(dummyVars(:,2:end), 2); % Check actual column count
data = [data array2table(dummyVars(:,2:end), 'VariableNames', {'Suburb','Urban','School'})];
data.district = [];
% 因变量变换
data.log_price = log(data.price);
data.price = [];
save('data.mat','data')

%% 拟合
model = fitlm(data, 'log_price ~ area_sq + house_age + garden + Suburb + Urban + School')

