# Ejemplo 2. Conexi?n a una BDD con R

# Comenzaremos instalando las librerias necesarias para realizar la conexi?n y 
# lectura de la base de datos en RStudio, si previamente los ten?as instalados 
# omite la instalaci?n, recuerda que solo necesitas realizarla una vez.

install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")

library(DBI)
library(RMySQL)

# Una vez que se tengan las librerias necesarias se procede a la lectura 
# (podr?a ser que necesites otras, si te las solicita instalalas y cargalas), 
# de la base de datos de Shiny la cual es un demo y nos permite interactuar con 
# este tipo de objetos. El comando dbConnect es el indicado para realizar la 
# lectura, los dem?s parametros son los que nos dan acceso a la BDD.

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Si no se arrojaron errores por parte de R, vamos a explorar la BDD


dbListTables(MyDataBase) #Con esta instruccion podemos ver las tablas de la base de datos

# Ahora si se quieren desplegar los campos o variables que contiene la tabla 
# City se har? lo siguiente

dbListFields(MyDataBase, 'City') #Con esta instruccion vemos las variables de la tabla city

# Para realizar una consulta tipo MySQL sobre la tabla seleccionada haremos lo 
# siguiente

DataDB <- dbGetQuery(MyDataBase, "select * from City")

# Observemos que el objeto DataDB es un data frame, por lo tanto ya es un objeto 
# de R y podemos aplicar los comandos usuales

class(DataDB)
head(DataDB)


pop.mean <- mean(DataDB$Population)  # Media a la variable de poblaci?n
pop.mean 

pop.3 <- pop.mean *3   # Operaciones aritm?ticas
pop.3

# Incluso podemos hacer unos de otros comandos de busqueda aplicando la 
# libreria dplyr

library(dplyr)
pop50.mex <-  DataDB %>% filter(CountryCode == "MEX" ,  Population > 50000)   # Ciudades del pa?s de M?xico con m?s de 50,000 habitantes

head(pop50.mex)

unique(DataDB$CountryCode)   # Pa?ses que contiene la BDD

#Nos desconectamos de la base de datos
dbDisconnect(MyDataBase)

