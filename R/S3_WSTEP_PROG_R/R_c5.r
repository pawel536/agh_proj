install.packages("gapminder")
install.packages("dplyr")

library("gapminder")
library(dplyr)

#head("gapminder")
#tail("starwars")
#str("starwars")

glimpse(gapminder)

slice(gapminder, 12:20)  #dane z wierszy 12-20

gapminder%>%  #kolumna 1957 rok
  filter(year==1957)

gapminder%>%
  arrange(desc(lifeExp))  #z kolumny  sort w dół

gapminder%>%
  mutate(lifeExp=lifeExp*12)  #edycja

gapminder%>%
  summarize(medianlifeExp=median(lifeExp)) #poj tibble

gapminder%>%
  group_by(year)%>%
    summarize(medianlifeExp=median(lifeExp), maxGdpPercap=max(gdpPercap))

#######

gapminder%>%
  filter(country=="China", year==2002)

gapminder%>%
  filter(year==1957)%>%
    arrange(pop)

gapminder%>%
  filter(year==2007)%>%
    mutate(lifeExpMonths=lifeExp*12)%>%
      arrange(desc(lifeExpMonths))

gapminder%>%
  filter(year==1957)%>%
    summarize(medianlifeExp=median(lifeExp), maxGdpPercap=max(gdpPercap))

gapminder%>%
  group_by(continent)%>%  #group_by(year,continent)%>%
    group_by(year)%>%
      summarize(medianLifeExp=median(lifeExp), meanGdpPercap=mean(gdpPercap))

#######
glimpse(starwars)
  
starwars%>%     #filter(starwars, species == "Mirialan")
  filter(species == "Mirialan")

starwars%>%     #select(starwars, ends_with("color"))
  select(name,ends_with("color"))

starwars%>% 
  mutate(bmi=(mass*10000)/(height*height))%>%
    select(name, bmi)

starwars%>%     #count(starwars,sex)
  group_by(species)%>%
    summarize(n=n(),mass=mean(mass),height=max(height))%>%
      filter(n>=2,mass>60)

slice(starwars, 13:14)

starwars%>%     #select(starwars, name, sex, homeworld) 
  select(name,sex,homeworld)

na_species<-starwars%>%
  filter(is.na(species))%>%
    select(name,sex,homeworld)
na_species

starwars%>%     #count(starwars,sex)
  group_by(sex)%>%
    summarize(n=n())

starwars %>%
  filter(skin_color=='fair', eye_color=='brown') %>%
    select(name, skin_color, eye_color, sex)%>%
      arrange(sex)

starwars%>%
  slice_sample(n=5)

starwars%>%
  filter(!is.na(height))%>%
    arrange(desc(height))

starwars%>%
  filter(!is.na(height))%>%
    mutate(height_m=height*0.01)%>%
      select(name,height_m)

