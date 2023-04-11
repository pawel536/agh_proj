import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import dataframe_image as dfi

eruptions_data = pd.read_csv("eruptions_data.csv", header=0, index_col="Eruption Number")
print(eruptions_data)
big_eruptions_data = eruptions_data[eruptions_data.loc[:, 'VEI'] == 7]
print(big_eruptions_data)

most_active_data = pd.DataFrame(eruptions_data["Volcano Name"].value_counts())
most_active_data.reset_index(inplace=True)
most_active_data = pd.DataFrame({"Volcano": most_active_data["index"],
                                 "Recorded eruptions": most_active_data["Volcano Name"]})
most_active_data.style.format({'Recorded eruptions': '{:d}'}).format_index('{:d}').hide(most_active_data.index[10:])

last_eruption_data = eruptions_data.groupby(["VEI"])["Start Year"].max()
last_eruption_data = pd.DataFrame(last_eruption_data)
last_eruption_data.rename(columns={"Start Year": "Last recorded eruption"}, inplace=True)
last_eruption_data.style.format('{:.0f}').format_index('{:.0f}')

vei_data_1 = pd.DataFrame()
vei_data_1['f'] = eruptions_data.groupby('VEI')['VEI'].count()
vei_data_1['cf'] = vei_data_1['f'].cumsum()
vei_data_1['rf'] = vei_data_1['f'] / vei_data_1['f'].sum()
vei_data_1['crf'] = vei_data_1['rf'].cumsum()
vei_data_1.style.format({'f': '{:d}', 'cf': '{:d}', 'rf': '{:.4f}', 'crf': '{:.4f}'}, na_rep='nan').format_index(
    '{:.0f}')

vei_data_2 = pd.DataFrame()
vei_data_2['f'] = eruptions_data[eruptions_data['Eruption Category'] == 'Confirmed'].groupby('VEI')['VEI'].count()
vei_data_2['cf'] = vei_data_2['f'].cumsum()
vei_data_2['rf'] = vei_data_2['f'] / vei_data_2['f'].sum()
vei_data_2['crf'] = vei_data_2['rf'].cumsum()
vei_data_2.style.format({'f': '{:d}', 'cf': '{:d}', 'rf': '{:.4f}', 'crf': '{:.4f}'}, na_rep='nan').format_index(
    '{:.0f}')

vei_data_3 = pd.DataFrame()
vei_data_3['f'] = eruptions_data[eruptions_data['Eruption Category'] == 'Uncertain'].groupby('VEI')['VEI'].count()
vei_data_3['cf'] = vei_data_3['f'].cumsum()
vei_data_3['rf'] = vei_data_3['f'] / vei_data_3['f'].sum()
vei_data_3['crf'] = vei_data_3['rf'].cumsum()
vei_data_3.style.format({'f': '{:d}', 'cf': '{:d}', 'rf': '{:.4f}', 'crf': '{:.4f}'}, na_rep='nan').format_index(
    '{:.0f}')

fig, ax = plt.subplots(1, 3, figsize=(18, 6))
fig.suptitle('Szeregi rozdzielcze VEI', size=18)
fig.set_facecolor("w")

ax0 = ax[0].twinx()
ax1 = ax[1].twinx()
ax2 = ax[2].twinx()

ax[0].bar(vei_data_1.index, vei_data_1['f'], color="orange")
ax0.plot(vei_data_1.index, vei_data_1['crf'], color="red")
ax[0].set_xticks([0, 1, 2, 3, 4, 5, 6, 7])

ax[1].bar(vei_data_2.index, vei_data_2['f'], color="orange")
ax1.plot(vei_data_2.index, vei_data_2['crf'], color="red")
ax[1].set_xticks([0, 1, 2, 3, 4, 5, 6, 7])

ax[2].bar(vei_data_3.index, vei_data_3['f'], color="orange")
ax2.plot(vei_data_3.index, vei_data_3['crf'], color="red")
ax[2].set_xticks([0, 1, 2, 3, 4, 5, 6, 7])

ax[0].set_title('All eruptions')
ax[1].set_title('Confirmed eruptions')
ax[2].set_title('Uncertain eruptions')
ax[0].set_xlabel('VEI')
ax[1].set_xlabel('VEI')
ax[2].set_xlabel('VEI')

ax[0].set_ylim(0, 4500)
ax[1].set_ylim(0, 4500)
ax[2].set_ylim(0, 4500)
ax0.set_ylim(-0.01, 1.01)
ax1.set_ylim(-0.01, 1.01)
ax2.set_ylim(-0.01, 1.01)

ax0.spines['left'].set_color("orange")
ax1.spines['left'].set_color("orange")
ax2.spines['left'].set_color("orange")
ax0.spines['right'].set_color('red')
ax1.spines['right'].set_color('red')
ax2.spines['right'].set_color('red')
ax[0].set_ylabel('f').set_color("orange")
ax[1].set_ylabel('f').set_color("orange")
ax[2].set_ylabel('f').set_color("orange")
ax0.set_ylabel('crf').set_color('red')
ax1.set_ylabel('crf').set_color('red')
ax2.set_ylabel('crf').set_color('red')
ax[0].tick_params(axis='y', colors='orange')
ax[1].tick_params(axis='y', colors='orange')
ax[2].tick_params(axis='y', colors='orange')
ax0.tick_params(axis='y', colors='red')
ax1.tick_params(axis='y', colors='red')
ax2.tick_params(axis='y', colors='red')

plt.subplots_adjust(wspace=0.4, hspace=0.5)
plt.show()

# TESTY ZEWN
