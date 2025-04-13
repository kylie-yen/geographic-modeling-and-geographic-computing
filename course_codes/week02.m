%% 数据清洗
% 生成一个7x4的随机数组
% A = rand(7, 4);

% sub行列索引 转为线性索引index
% linearIndices = sub2ind(size(A), indices, cols);

% 缺失值处理相关函数
% ismissing(),TF的逻辑数组
% fillmissing()，fillmissing(data,'constant',0)，填充
% rmmissing(),clean_data = rmmissing(data,'MinNumMissing',2) 默认按行删除，
% 删除含两个以上缺失值的行

% 异常值处理
% 检查，单变量：箱线图、Z-score，多变量：聚类、马氏距离
% 处理方法：删除、修正、转换（右偏数据取对数）、分箱（分组，将连续数据离散，比如年龄0-18、19-30，各段内信息杂乱，分箱后屏蔽杂乱，多尺度的观念）
% isoutlier(data, ThresholdFactor,3) 三倍标准差外的值或者mean quartiles
% filloutliers(data,'median','movmedian',5) 窗口大小为5的移动中位数
% prctile(data,[25 75]) 获取上下四分位数

% 重复数据
% 由数据重复录入、爬虫重复抓取等导致
% [c, ia]=unique(data,'rows') 提取唯一值或唯一行，结合索引删除重复项

%% 课堂练习
% 读取数据
data = readtable("house_price_data.xlsx");

% 1.缺失值
clean1 = rmmissing(data);

% 2.去除重复值
clean2 = unique(clean1);

% 3.替换异常值
clean3 = filloutliers(clean2, 'center', 'movmedian',5);

% 保存
writetable(clean3, 'hand_house_price_data_cleaned.xlsx');

% 回归


%% qwen-version
% 读取Excel文件
data = readtable('house_price_data.xlsx');


% 缺失值处理
% 对于area列使用移动中位数填补（假设窗口大小为5）
data.area = fillmissing(data.area, 'movmedian', 5);

% house_age用中位数填充（忽略NaN）
data.house_age = fillmissing(data.house_age, 'constant', median(data.house_age, 'omitnan'));

% district用0填充
data.district = fillmissing(data.district, 'constant', 0);


% 异常值处理
% 计算area的99分位数
area_q99 = prctile(data.area, 99);
% 将大于99分位数的area值替换为99分位数值
data.area(data.area > area_q99) = area_q99;

% 同理处理price
price_q99 = prctile(data.price, 99);
data.price(data.price > price_q99) = price_q99;

% house_age不能为负数，如果是负数则设置为0
data.house_age(data.house_age < 0) = 0;

% price同理
data.price(data.price < 0) = 0;

% 删除重复行
data = unique(data, 'rows');

% 保存清洗后的数据到新的Excel文件
writetable(data, 'cleaned_house_price_data.xlsx');

%% gpt-version
% 读取Excel数据
data = readtable('house_price_data.xlsx');

% 处理缺失值
data.area = fillmissing(data.area, 'movmedian', 10);
data.house_age = fillmissing(data.house_age, 'constant', median(data.house_age, 'omitnan'));
data.district = fillmissing(data.district, 'constant', 0);

% 处理异常值
area_q99 = prctile(data.area, 99);
price_q99 = prctile(data.price, 99);

data.area(data.area > area_q99) = area_q99;
data.price(data.price > price_q99) = price_q99;
data.house_age(data.house_age < 0) = median(data.house_age, 'omitnan');  % 负值替换为中位数

% 删除重复行
data = unique(data, 'rows');

% 保存清洗后的数据
writetable(data, 'house_price_data_cleaned.xlsx');

disp('数据清洗完成，已保存至 house_price_data_cleaned.xlsx');

model = fitlm(data, 'price ~ area + house_age + garden + district + area')

%% yxx-version
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

model = fitlm(data, 'price ~ area + house_age + garden + district + area')


