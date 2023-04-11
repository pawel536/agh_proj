import numpy as np
import pandas as pd
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import dataframe_image as dfi

eruptions_data = pd.read_csv("eruptions_data.csv", header=0, index_col="Eruption Number")
print(eruptions_data)

vei_data = pd.DataFrame(index=eruptions_data.groupby(['VEI'])['VEI'].count().index,
                        columns=pd.MultiIndex.from_product(
                            [['All eruptions', 'Confirmed Eruptions', 'Uncertain Eruptions'],
                             ['f', 'cf', 'rf', 'crf']]))

vei_data.loc[:, ('All eruptions', 'f')] = pd.Series(eruptions_data.groupby('VEI')['VEI'].count())
vei_data.loc[:, ('All eruptions', 'cf')] = vei_data.loc[:, ('All eruptions', 'f')].cumsum()
vei_data.loc[:, ('All eruptions', 'rf')] = vei_data.loc[:, ('All eruptions', 'f')] / \
                                           vei_data.loc[:, ('All eruptions', 'f')].sum()
vei_data.loc[:, ('All eruptions', 'crf')] = vei_data.loc[:, ('All eruptions', 'rf')].cumsum()

vei_data.loc[:, ('Confirmed Eruptions', 'f')] = pd.Series(
    eruptions_data[eruptions_data['Eruption Category'] == 'Confirmed'].groupby('VEI')['VEI'].count())
vei_data.loc[:, ('Confirmed Eruptions', 'cf')] = vei_data.loc[:, ('Confirmed Eruptions', 'f')].cumsum()
vei_data.loc[:, ('Confirmed Eruptions', 'rf')] = vei_data.loc[:, ('Confirmed Eruptions', 'f')] / \
                                                 vei_data.loc[:, ('Confirmed Eruptions', 'f')].sum()
vei_data.loc[:, ('Confirmed Eruptions', 'crf')] = vei_data.loc[:, ('Confirmed Eruptions', 'rf')].cumsum()

vei_data.loc[:, ('Uncertain Eruptions', 'f')] = pd.Series(
    eruptions_data[eruptions_data['Eruption Category'] == 'Uncertain'].groupby('VEI')['VEI'].count())
vei_data.loc[:, ('Uncertain Eruptions', 'cf')] = vei_data.loc[:, ('Uncertain Eruptions', 'f')].cumsum()
vei_data.loc[:, ('Uncertain Eruptions', 'rf')] = vei_data.loc[:, ('Uncertain Eruptions', 'f')] / \
                                                 vei_data.loc[:, ('Uncertain Eruptions', 'f')].sum()
vei_data.loc[:, ('Uncertain Eruptions', 'crf')] = vei_data.loc[:, ('Uncertain Eruptions', 'rf')].cumsum()

vei_data = vei_data.astype(float)
v = vei_data.style.format(
    {('All eruptions', 'f'): '{:.0f}', ('All eruptions', 'cf'): '{:.0f}', ('All eruptions', 'rf'): '{:.4f}',
     ('All eruptions', 'crf'): '{:.4f}',
     ('Confirmed Eruptions', 'f'): '{:.0f}', ('Confirmed Eruptions', 'cf'): '{:.0f}',
     ('Confirmed Eruptions', 'rf'): '{:.4f}', ('Confirmed Eruptions', 'crf'): '{:.4f}',
     ('Uncertain Eruptions', 'f'): '{:.0f}', ('Uncertain Eruptions', 'cf'): '{:.0f}',
     ('Uncertain Eruptions', 'rf'): '{:.4f}', ('Uncertain Eruptions', 'crf'): '{:.4f}'},
    na_rep='nan').format_index('{:.0f}')
print(v)

fig, ax = plt.subplots(1, 3, figsize=(18, 6))
fig.suptitle('Szeregi rozdzielcze VEI', size=18)
fig.set_facecolor("w")

ax0 = ax[0].twinx()
ax1 = ax[1].twinx()
ax2 = ax[2].twinx()

ax[0].bar(vei_data.index, vei_data['All eruptions']['f'], color="orange")
ax0.plot(vei_data.index, vei_data['All eruptions']['crf'], color="red")
ax[0].set_xticks([0, 1, 2, 3, 4, 5, 6, 7])

ax[1].bar(vei_data.index, vei_data['Confirmed Eruptions']['f'], color="orange")
ax1.plot(vei_data.index, vei_data['Confirmed Eruptions']['crf'], color="red")
ax[1].set_xticks([0, 1, 2, 3, 4, 5, 6, 7])

ax[2].bar(vei_data.index, vei_data['Uncertain Eruptions']['f'], color="orange")
ax2.plot(vei_data.index, vei_data['Uncertain Eruptions']['crf'], color="red")
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
fig.savefig('i1.png')
plt.show()

#####

evidence_data = pd.DataFrame(index=eruptions_data.groupby(['Evidence Type', 'Evidence Method'])['VEI'].count().index)
lst = np.sort(pd.unique(eruptions_data.loc[:, 'VEI']))

for i in lst:
    evidence_data[i] = eruptions_data[eruptions_data['VEI'] == i].groupby(['Evidence Type', 'Evidence Method'])[
        ['VEI']].count()
evidence_data['All'] = eruptions_data.groupby(['Evidence Type', 'Evidence Method'])[['VEI']].count()
evidence_data.fillna(0, inplace=True)
evidence_data.style.format('{:.0f}', na_rep='nan').format_index(axis=1, precision=0)

fig, ax = plt.subplots(2, 1, figsize=(15, 10))
fig.suptitle('Rozkład zarejestrowanych erupcji', size=18)
fig.set_facecolor("w")

sns.stripplot(data=eruptions_data, x="VEI", y="Start Year", ax=ax[0], alpha=.3)
sns.stripplot(data=eruptions_data, x="VEI", y="Start Year", hue="Evidence Type", dodge=True, ax=ax[1], alpha=0.2)

ax[0].set_title('Types grouped by VEI')
ax[1].set_title('Types grouped by VEI and Evidence Type')
ax[0].set_xlabel('VEI')
ax[1].set_xlabel('VEI')
ax[0].set_ylabel('Start Year')
ax[1].set_ylabel('Start Year')

ax[0].set_ylim(-12000, 2025)
ax[1].set_ylim(-12000, 2025)
ax[1].legend(loc='lower right', ncol=6, fontsize='x-small')

ax[0].set_xticks(ticks=[0, 1, 2, 3, 4, 5, 6, 7], labels=['0', '1', '2', '3', '4', '5', '6', '7'])
ax[1].set_xticks(ticks=[0, 1, 2, 3, 4, 5, 6, 7], labels=['0', '1', '2', '3', '4', '5', '6', '7'])

plt.subplots_adjust(wspace=0.4, hspace=0.3)
fig.savefig('i2.png')
plt.show()


# TESTY ZEWN
