#!/usr/bin/env python
# -*- coding: utf-8 -*-

##Datos de prueba:

E=["a","b"]
'''L=[("Q0","a","Q2"),
   ("Q0","b","Q0"),
   ("Q0","","Q1"),
   ("Q1","a","Q4"),
   ("Q1","b","Q1"),
   ("Q2","a","Q0"),
   ("Q3","a","Q1"),
   ("Q4","a","Q4")]'''
#Ejemplo con el ejercicio de la prueba
L=[("Q0", "a", "Q2"),
    ("Q0", "b", "Q0"),
    ("Q0", "", "Q1"),
    ("Q2", "a", "Q0"),
    ("Q4", "a" "Q3"),
    ("Q3", "a", "Q1"),
    ("Q1", "b", "Q1"),
    ("Q1", "", "Q4"),
    ("Q1", "b", "Q1")]
    
K=["Q0","Q1","Q2","Q3","Q4"]
S=["Q0"]
F=["Q1"]

M=[K,E,S,L,F]

tabla = {}

def combinarListas(l1, l2):
    #Se toman dos listas y se comprueba que la segunda sea del tipo "lista" antes de agregarlo
    aux = l1
    if type(l2) == list:
        aux.extend(l2)
    else:
        aux.append(l2)
    
    #Se comprueba si es que los elementos de la unión no se repiten
    #Si el elemento de la unión no existe en la lista final, se agrega
    listaFinal = []
    for elemento in aux:
        try:
            listaFinal.index(elemento)
        except ValueError:
            listaFinal.append(elemento)
    return listaFinal

def conexionesConVacio(lista, nodo):
    #Devuelve una lista con los nodos que se ven unidos por un vacío al nodo de entrada
    nodosVacios = []
    for tupla in lista:
        if(nodo == tupla[0] and tupla[1] == ""):
            nodosVacios = combinarListas(nodosVacios, tupla[2]) 
            nodosVacios = combinarListas(nodosVacios, conexionesConVacio(lista, tupla[2]))
    return nodosVacios

def procesarNodo(lista, alfabeto, nodo):
    #Se crea un diccionario para guardar las listas de nodos que se podrán leer con cada carácter
    diccionario = {}

    #Se recorre la lista y compara que el primer elemento de la tupla sea el nodo ingresado
    #Si el carácter no existe en el diccionario, se crea
    for tupla in lista:
        if (nodo == tupla[0]):
            for caracter in alfabeto:
                if (tupla[1] == caracter):
                    if caracter not in diccionario:
                        diccionario[caracter] = []
                    
                    diccionario[caracter]= combinarListas(diccionario[caracter],tupla[2])
                    diccionario[caracter]= combinarListas(diccionario[caracter], conexionesConVacio(lista, tupla[2]))

            if(tupla[1] == ""):
                aux=procesarNodo(lista, alfabeto, tupla[2])
                for c, e in aux.items():
                    print(c,e)
                    if c in diccionario:
                        diccionario[c] = combinarListas(diccionario[c], e)
                    else:
                        diccionario[c] = []
                        diccionario[c] = combinarListas(diccionario[c], e)
    return diccionario

##Transformación de AFND a AFD
def etiquetas(listaDeNodos):
    #Devuelve el nombre en string que recibe un nodo
    aux = ''
    for elemento in listaDeNodos:
        aux += elemento
    return aux

def procesarNodoAFD(nodo, AFND, tabla):
    #Se crea un elemento de la tabla comenzando por la etiqueta
    etiquetaNodo = etiquetas(nodo)
    tabla[etiquetaNodo] = {}

    #Por cada elemento que componga el nodo, se recorre AFND para crear los conjuntos
    #de nodos a los que se puedan conectar mediante el alfabeto
    #Luego llama recursivamente la función cambiando el nodo del parámetro
    print(nodo)
    for elemento in nodo:
        for caracter in AFND[elemento].keys():

            if caracter not in tabla[etiquetaNodo]:

                tabla[etiquetaNodo][caracter] = []

            tabla[etiquetaNodo][caracter] = combinarListas(tabla[etiquetaNodo][caracter], AFND[elemento][caracter])
            etiqueta = etiquetas(tabla[etiquetaNodo][caracter])
            print(tabla[etiquetaNodo][caracter])
            # if etiqueta not in tabla:
            #     procesarNodoAFD(tabla[etiquetaNodo][caracter], AFND, tabla)
    return tabla

def AFD(AFND, lista, nodo, alfabeto):
    #Se define el nodo inicial
    tabla = {}
    nodoInicial = [nodo]
    print('nodo inicial 1:',nodoInicial)
    nodoInicial = combinarListas(nodoInicial, conexionesConVacio(lista, nodo))
    print('nodo inicial 2:',nodoInicial)
    #Teniendo el nodo inicial se llama la función recursiva para completar la tabla
    etiqueta = etiquetas(nodoInicial)

    procesarNodoAFD(nodoInicial, AFND, tabla)

    haySumidero = False
    
    #Se comprueba la existencia de cada carácter por nodo en el diccionario
    for caracter in alfabeto:
        for nodoAux in tabla:
            if caracter not in tabla[nodoAux]:
                tabla[nodoAux][caracter] = ["S"]
                haySumidero = True
    
    #En caso de existir el sumidero, este se agrega
    if haySumidero:
        diccionarioAux = {}
        for caracter in alfabeto:
            diccionarioAux[caracter] = ["S"]
        tabla["S"] = diccionarioAux
    return tabla

##Aquí comienza el main##
def opciones():
    print("\n\tMenu principal")
    print("(1) ")
    print("(2)")
    print("(3)")
    print("(4)")
    print("(0) Salir")

def menu():
    while True:
        opciones()
        opcion = input("Ingrese una opcion: ")

        if opcion == 1:
            print("Opcion 1")
        elif opcion == 2:
            print("Opcion 2")
        elif opcion == 3:
            print("Opcion 3")
        elif opcion == 4:
            print("Opcion 4")
        elif opcion == 0:
            break
        else:
            print("Opcion invalida")

def main():
    print("Grafos y lenguajes formales\n21041|INFB8061-1\n\nTrabajo 2: Automata\n")
    print("Integrantes:\n")
    print("- Felipe Flores Vivanco\n- Andres Mella\n- Jorge Verdugo Chacon\n- Javiera Vergara Navarro")
    menu()

for nodo in K:
    aux=procesarNodo(L, E, nodo)
    tabla[nodo] = aux
# {"Q0Q1Q4"=>{""=>{""=>nil}}, ""=>{"a"=>{"Q4"=>nil}},
#  "Q4Q1"=>{"b"=>{"Q4"=>nil, "Q1"=>nil}, ""=>{""=>nil}},
#   "Q4"=>{"b"=>{"Q4"=>nil},
#    ""=>{""=>nil}}}1)

# {"Q0"=>{""=>{""=>nil}, "a"=>{"Q4"=>nil, "Q1"=>nil}, "b"=>{"Q4"=>nil, "Q1"=>nil}}, "Q1"=>{""=>{""=>nil}, "a"=>{"Q4"=>nil}, "b"=>{"Q4"=>nil}}, "Q2"=>{"a"=>{"Q0"=>nil}}, "Q3"=>{"a"=>{"Q1"=>nil}}, "Q4"=>{""=>{""=>nil}}, "S"=>{}
# lo que manda en AFND es la tabla de transiciones 
print (tabla)
# print(AFD(tabla, L, S[0], E))
#Llamada del main, se comenta por mientras uwu
#main()
                # {'Q0': {
                #     'a': ['Q2'],
                #     'b': ['Q0', 'Q1', 'Q4']},
                # 'Q1': {'b': ['Q1', 'Q4']}, 
                # 'Q2': {'a': ['Q0', 'Q1', 'Q4']}, 
                # 'Q3': {'a': ['Q1', 'Q4']}, 
                # 'Q4': {}}



                # {:E=>{"a"=>nil, "b"=>nil},
                # :K=>{"Q0"=>nil, "Q1"=>nil, "Q2"=>nil, "Q3"=>nil, "Q4"=>nil, "S"=>nil}, 
                # :L=>{
                #     "Q0"=>{"a"=>"Q2", "b"=>"Q0", "&"=>"Q1"}, 
                #     "Q1"=>{"b"=>"Q1", "&"=>"Q4"}, 
                #     "Q2"=>{"a"=>"Q0"}, 
                #     "Q3"=>{"a"=>"Q1"}, 
                #     "Q4"=>{"a"=>"Q3"}}, 
                # :S=>{"Q0"=>nil}, 
                # :F=>{"Q1"=>nil}}


#                     {"Q0"=>{"a"=>{"Q3"=>nil, {...}=>nil, {...}=>nil}}, 
#                     "Q1"=>{"a"=>{"Q3"=>nil, {...}=>nil}}, 
#                     "Q2"=>{"a"=>{"Q0"=>nil}}, 
#                     "Q3"=>{"a"=>{"Q1"=>nil}},
#                      "Q4"=>{"a"=>{"Q3"=>nil}}, 
#                      "S"=>{}}1)

# {"q0"=>{"a"=>{"q1"=>nil}},
#  "q1"=>{"a"=>{"q1"=>nil}},
#   "S"=>{}}1)

#   {"Q0"=>{"a"=>{"Q3"=>nil}},
#    "Q1"=>{"a"=>{"Q3"=>nil}},
#    "Q2"=>{"a"=>{"Q0"=>nil}},
#     "Q3"=>{"a"=>{"Q1"=>nil}},
#      "Q4"=>{"a"=>{"Q3"=>nil}},
#       "S"=>{}}1)

#       {"q0"=>{"b"=>{"q2"=>nil}, "a"=>{"q0"=>nil}},
#        "q1"=>{"b"=>{"q2"=>nil}},
#         "q2"=>{"a"=>{"q2"=>nil}},
#          "S"=>{}}1)

#          {"Q0"=>{"A"=>{"Q3"=>nil}, "0"=>{"0"=>nil}},
#           "Q1"=>{"A"=>{"Q3"=>nil}, "0"=>{"0"=>nil}},
#            "Q2"=>{"A"=>{"Q0"=>nil}},
#             "Q3"=>{"A"=>{"Q1"=>nil}}, 
#             "Q4"=>{"A"=>{"Q3"=>nil}},
#              "S"=>{}}1)

