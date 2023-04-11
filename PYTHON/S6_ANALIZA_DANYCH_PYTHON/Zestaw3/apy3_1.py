import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import dataframe_image as dfi
from datetime import datetime

# analiza danych o rowerach i o pogodzie w 2022r na podstawie danych z:
# https://data.seattle.gov/Transportation/Fremont-Bridge-Bicycle-Counter/65db-xm6k
# https://forecast.weather.gov/product.php?site=SEW&product=CF6&issuedby=SEW

bike_traffic_data = pd.read_csv("./raw_bike_traffic_data.csv", header=0, index_col="Date", parse_dates=True)
bike_traffic_data.columns = ['Total', 'East', 'West']
bike_traffic_data.index = bike_traffic_data.index.to_period("H")
bike_traffic_data = bike_traffic_data.loc[bike_traffic_data.index.year == 2022]
bike_traffic_data.to_pickle("./bike_traffic_data.pkl")
bike_traffic_data.style.format(na_rep='nan', precision=0).hide(bike_traffic_data.index[12:-12])

# TESTY ZEWN

fields = ["MIN", "AVG", "MAX", "WTR", "SNW", "DPTH", "SPD", "SPD.1", "S-S"]
pom = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
nofrows = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
path = "./raw_weather_data/2022_01.txt"

weather_data = pd.read_csv(path, sep="\s+", skiprows=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17],
                           nrows=nofrows[0], usecols=fields, na_values="M")

for i in range(1, 12):
    path = "./raw_weather_data/2022_" + pom[i] + ".txt"
    weather_data = pd.concat(
        [weather_data, pd.read_csv(path, sep="\s+", skiprows=[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17],
                                   nrows=nofrows[i], usecols=fields, na_values="M")], ignore_index=True)

weather_data.iloc[:, 3:6] = weather_data.iloc[:, 3:6].replace('T', 0)
# podmiana na zero - nie mozna bylo wczytywac T jako NA !!!
# weather_data.iloc[:, 3:6] = weather_data.iloc[:, 3:6].astype('float') TU FUTURE WARNING
weather_data[weather_data.columns[3:6]] = weather_data.iloc[:, 3:6].astype('float')
weather_data.iloc[:, 0:3] = (weather_data.iloc[:, 0:3] - 32) * 5 / 9
weather_data.iloc[:, 3:6] = weather_data.iloc[:, 3:6] * 25.4
weather_data.iloc[:, 6:8] = weather_data.iloc[:, 6:8] * 1609.34 / 3600
weather_data.iloc[:, 8] = weather_data.iloc[:, 8] / 10

cols = weather_data.columns.tolist()  # ZABAWA Z KOLEJNOŚCIĄ KOLUMN
cols = cols[1:3] + cols[0:1] + cols[3:]
weather_data = weather_data[cols]

cols2 = ('Temperature', 'Min'), ('Temperature', 'Avg'), ('Temperature', 'Max'), ('Precipitation', 'Total'), \
    ('Snow', 'Fall'), ('Snow', 'Depth'), ('Wind', 'Avg speed'), ('Wind', 'Max speed'), ('Sky', 'Cloud cover')
weather_data.columns = pd.MultiIndex.from_tuples(cols2)  # TWORZENIE WIELOPOZIOMOWYCH KOLUMN

weather_data.index = pd.period_range(datetime(2022, 1, 1), datetime(2022, 12, 31), freq="D")
weather_data.index.name = 'Date'

weather_data.to_pickle("./weather_data.pkl")
weather_data.style.format(na_rep='nan', precision=2).hide(weather_data.index[10:-10])
