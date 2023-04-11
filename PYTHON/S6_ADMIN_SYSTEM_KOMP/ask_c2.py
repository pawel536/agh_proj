import re
import pandas as pd

if __name__ == '__main__':
    with open('./ilus0.csv') as f:
        with open('./ilus3.txt', 'a') as f1:
            txt = f.read()
            x = re.sub(r',', '\t', txt)
            f1.write(x)

# lines = f.readlines()
# line_num = -1
# for k, line in enumerate(lines):
# if line.find("invalid user") != -1:
# line_num = k
# f1.write(line)

# data = pd.read_csv("ilus.csv", header=0, index_col=0)
# data = pd.read_csv("dictfinal.csv")
# print(data)
# cols = data.columns.tolist()
# cols = cols[0:3] + cols[5:9] + [cols[4]] + [cols[3]]
# print(cols)
# data = data[cols]
# print(data)
# data.to_csv("ilus0.csv")

# t = data.groupby(["ip1", "ip2", "ip3", "ip4"])[["ip1", "ip2", "ip3", "ip4"]].any()
# print(t.index)
# l = ["admin"]
# print(data.loc[0, :])
# for i in range(1, len(data)):
#     if data.loc[i-1, "ip4"] == data.loc[i, "ip4"]:
#         l.append(data.loc[i, "user"])
#     else:
#         print(data.loc[i-1, "ip1"], ".", data.loc[i-1, "ip2"], ".", data.loc[i-1, "ip3"],
#               data.loc[i-1, "ip4"], ":", l)
#         l = [data.loc[i, "user"]]

# g = []
# for x in data.index.unique():
# print(x)
# g.append(x)
# print(data[x].unique())
# print(g)
# for i in g:
# print(i)
# l = []
# for j in data:
# if j == i:
# l.append(j["users"])
# print(l)

# d1 = data.groupby(["ip1", "ip2", "ip3", "ip4", "user"])["user"].count()
# print(d1)
# d1.to_csv("dictfinal.csv")
# d2 = data[data["ip1"] == 1]
# print(d2)

# data.drop([3, 7], axis=1, inplace=True)
# data.columns = ["mon", "day", "time", "user", "ip", "port"]
# data[['ip1', 'ip2', 'ip3', 'ip4']] = data["ip"].str.split(".", expand=True)
# data.drop(["ip"], axis=1, inplace=True)
# print(data)
# data.to_csv("ilus.csv")

# if txt.find("invalid user") != -1:
# x = re.findall("invalid user ubuntu ", txt)
# x = re.sub(r' lab3', '', txt)
# x = re.sub(r': Failed password for invalid user', '', x)
# x = re.sub(r' port', '', x)
# x = re.sub(r'ssh2', '', x)
# x = re.sub(r'ssh2]', 'ssh2', x)
# print(x)
