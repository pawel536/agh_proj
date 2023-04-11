import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import dataframe_image as dfi

eruptions_data = pd.read_csv("raw_data.csv", header=1, index_col="Eruption Number")

eruptions_data = eruptions_data.loc[:,
                 ["Volcano Name", "Eruption Category", "Evidence Method (dating)", "VEI", "Start Year", "Start Month",
                  "Start Day", "End Year", "End Month", "End Day"]]
eruptions_data[['Evidence Type', 'Evidence Method']] = eruptions_data["Evidence Method (dating)"].str.split(": ",
                                                                                                            expand=True)
eruptions_data.drop("Evidence Method (dating)", axis=1, inplace=True)

eruptions_data = eruptions_data[(eruptions_data.loc[:, "Eruption Category"] != "Discredited Eruption") & (
        pd.isna(eruptions_data.loc[:, "VEI"]) is False)]
eruptions_data['Eruption Category'] = eruptions_data['Eruption Category'].str.replace(" Eruption", "")
eruptions_data['Evidence Type'].fillna("Uncertain", axis=0, inplace=True)
eruptions_data['Evidence Method'].fillna("Unspecified", axis=0, inplace=True)
# print( eruptions_data['Evidence Type'].unique() )
# print( eruptions_data['Evidence Method'].unique() )

eruptions_data.loc[:, ["Start Month", "Start Day", "End Month", "End Day"]] = eruptions_data.loc[:,
                                                                              ["Start Month", "Start Day", "End Month",
                                                                               "End Day"]].replace(0.0, np.nan)
# .fillna(0) w druga strone

# eruptions_data = eruptions_data.astype({"Start Day":"Int64", "Start Month":"Int64",
# "Start Year":"Int64", "End Day":"Int64", "End Month":"Int64", "End Year":"Int64", "VEI":"int"  })
# eruptions_data = eruptions_data.astype({"Volcano Name":"string", "Eruption Category":"string",
# "Evidence Type":"string", "Evidence Method":"string"})

ind = eruptions_data.index
eruptions_data.to_csv('eruptions_data.csv')
eruptions_data.style.format('{:.0f}', na_rep='nan', precision=0,
                            subset=["VEI", "Start Year", "Start Month",
                                    "Start Day", "End Year", "End Month", "End Day"]).hide(ind[10:-10])

# TESTY ZEWN
