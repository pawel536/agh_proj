import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
import random


# Tworzenie punktów startowych
def constr(nn, xl=None, yl=None):
    if xl is None:
        xl = [0, 100]
    if yl is None:
        yl = [0, 100]
    x = np.random.randint(xl[0], xl[1], nn)
    y = np.random.randint(yl[0], yl[1], nn)
    return np.stack((x, y), axis=1)


# Obliczanie sumarycznego dystansu
def sumdist(ord1, dst):
    s = 0
    for i in range(1, ord1.size):
        s += dst[ord1[i - 1]][ord1[i]]
    return s + dst[ord1[ord1.size - 1]][ord1[0]]


# Krzyżowanie pomiędzy dwoma ...
def crossgen(o1, o2, nn):
    o3 = o1
    st = np.random.randint(nn)
    ed = np.random.randint(nn)
    if st > ed:
        st, ed = ed, st
    lst = list(o1[st:ed + 1])
    j = 0
    for i in range(0, nn):
        if i < st or i > ed:
            while o2[j] in lst:
                j += 1
            o3[i] = o2[j]
            j += 1
    return o3


# Mutacja (forma - wymiana)
def mutation(o1, nn):
    mut1 = random.randint(0, nn - 1)
    mut2 = random.randint(0, nn - 1)
    o1[mut1], o1[mut2] = o1[mut2], o1[mut1]
    return o1


# Selekcja metodą rankingową [nieimplementowane]
def selection_ranking():
    pass


# Selekcja metodą ruletki
def selection_roulette(proulett, mm):
    p = np.random.uniform()
    for j in range(0, mm):
        if p <= proulett[j]:
            return j


# Tworzenie wykresów
def printorder(pt, ord1, xl, yl, bst, chang, nn, mm, ppk, ppm):
    print("Punkty: ", pt)
    print("Kolejność: ", ord1)
    fig, ax = plt.subplots(1, 2, figsize=(15, 10))
    ttl = 'Wykresy dla ' + str(nn) + ' pkt. , ' + str(mm) + ' osobn. , ' + \
          str(ppk) + ' pr. krzyż. , ' + str(ppm) + ' pr. mutacji:'
    fig.suptitle(ttl, size=30)
    ax[0].scatter(pt[:, 0], pt[:, 1], c='red', s=25)
    ax[0].plot([pt[ord1[i], 0] for i in range(0, ord1.size)] + [pt[ord1[0], 0]],
               [pt[ord1[i], 1] for i in range(0, ord1.size)] + [pt[ord1[0], 1]])
    ax[1].plot(bst[0, 0:chang], c='green')
    ax[1].plot(bst[1, 0:chang], c='yellow')
    ax[1].plot(bst[2, 0:chang], c='orange')
    ax[0].set_title('Wygenerowane punkty i ścieżka')
    ax[0].set_aspect(1)
    ax[0].set_xlim(xl[0], xl[1])
    ax[0].set_ylim(yl[0], yl[1])
    ax[0].set_xlabel('X')
    ax[0].set_ylabel('Y')
    ax[1].set_title('Min, avg i max dystans')
    ax[1].set_xlabel('iteracja')
    ax[1].set_ylabel('dystanse')
    plt.show()


# Funkcja główna
if __name__ == '__main__':
    xlim = [0, 300]  # Granice obszaru w poziomie
    ylim = [0, 300]  # Granice obszaru w pionie
    n = int(input("Podaj liczbe miast [int 2-50]:"))  # ilość miast - np 30
    m = int(input("Podaj liczbe osobnikow w pokoleniu [int 2-90]:"))  # ilość osobników w pokoleniu - np 40
    pk = float(input("Podaj prawd. krzyzowania [float 0.0-1.0]:"))  # prawd krzyzowania - np 0.9
    pm = float(input("Podaj prawd. mutacji [float 0.0-1.0]:"))  # prawd mutacji - np 0.1
    assert isinstance(n, int)
    assert isinstance(m, int)
    assert isinstance(pk, float)
    assert isinstance(pm, float)
    assert 1 < n < 51
    assert 1 < m < 91
    assert 0.0 <= pk <= 1.0
    assert 0.0 <= pm <= 1.0

    # Tworzenie wektora prawdopodobieństwa do metody ruletkowej
    proulette = 0.2 * np.ones(m) / m  # prawdopodob. do met. ruletkowej
    psum = m * (m + 1) / 2
    for k in range(0, m):
        proulette[k] += 0.8 * (m - k) / psum
    proulette = np.cumsum(proulette)  # print(proulette)

    # Losowanie punktów oraz obliczanie macierzy zawierającej odległości między nimi
    pts = constr(n, xlim, ylim)  # punkty x, y
    order = np.arange(n)
    dist = sp.spatial.distance_matrix(pts, pts)  # tablica wzajemnych odległości
    best = np.zeros((3, 5000))  # wektor do zapamiętania najlepszych rozwiązań w danym pokoleniu

    # generacja pokolenia początkowego
    pokolenie = np.zeros((m, n), dtype=int)  # nasze pokolenie t
    pokolenienast = np.zeros((m, n), dtype=int)  # nasze pokolenie t+1
    disttab = np.zeros(m)  # wektor sumy odległości dla każdego osobnika w pokoleniu
    for k in range(0, m):
        pokolenie[k] = np.random.permutation(order)
        disttab[k] = sumdist(pokolenie[k], dist)

    sortorder = np.argsort(disttab)
    pokolenie = pokolenie[sortorder[:], :]
    best[0, 0] = np.amin(disttab)
    best[1, 0] = np.mean(disttab)
    best[2, 0] = np.amax(disttab)

    itr = 0  # do kończenia pętli (przyjąłem max 5000 pokoleń)
    change = 0  # do kończenia pętli (jeśli nic się nie zmieni po 30 * n ieracjach)
    changemax = 30 * n
    while change < changemax and itr < 4999:  # pętla - not stable
        itr += 1
        change += 1
        changedist = disttab[0]  # do sprawdzenia czy dystans się poprawił w iteracji
        pokolenienast[0] = pokolenie[0]  # przepisuję najlepszego osobnika
        disttab[0] = sumdist(pokolenienast[0], dist)
        pom = 1  # jeżeli

        # tworzenie następnego pokolenia
        for k in range(1, m):
            if np.random.uniform() < pk:  # jeśli spełnione to losujemy ruletkowo
                r1 = selection_roulette(proulette, m)  # pierwszy indeks
                r2 = selection_roulette(proulette, m)  # drugi indeks
                pokolenienast[k] = crossgen(pokolenie[r1], pokolenie[r2], n)
            else:  # inaczej przepisujemy kolejnego najlepszego osobnika bez zmian
                pokolenienast[k] = pokolenie[pom]
                pom = pom + 1
            if np.random.uniform() < pm:  # jeśli spełnione to mutujemy osobnika
                pokolenienast[k] = mutation(pokolenienast[k], n)
            disttab[k] = sumdist(pokolenienast[k], dist)

        # sortowanie nowego pokolenia po odległości
        sortorder = np.argsort(disttab)  # print(sortorder)
        pokolenienast = pokolenienast[sortorder[:], :]
        if changedist != sumdist(pokolenienast[0], dist):
            change = 0

        # zapisywanie najmniejszej, średniej i nak=jw. odległości w pokoleniu
        # kopiowanie nowego pokolenia do głównej tablicy pokoleń
        best[0, itr] = np.amin(disttab)
        best[1, itr] = np.mean(disttab)
        best[2, itr] = np.amax(disttab)
        pokolenie[:] = pokolenienast[:]

    printorder(pts, pokolenie[0], xlim, ylim, best, itr, n, m, pk, pm)  # tworzenie wykresów po pętli
