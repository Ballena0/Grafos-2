#!/usr/bin/env ruby


def combinarListas(l1, l2)
    @aux = l1
    if type(l2) == list
        @aux.extend(l2)
    else
        @aux.append(l2)
    end
    @listaFinal = []
    @aux.each do |l1|
        try
            listaFinal.index(l1)
        except ValueError
            listaFinal.append(l1)
    end
end

def conexionesConVacio(lista, nodo)
    @nodosVacios = []
    for tupla in lista
        if (nodo == tupla[0] and tupla[1] == '')
            nodosVacios = combinarListas(nodosVacios, tupla[2])            
        end
    end
    return @nodosVacios
end

def procesarNodo(lista, alfabeto, nodo)
    diccionario = {}
    for tupla in lista 
        if (nodo == tupla[0])
            for caracter in alfabeto
                if (tupla[1] == caracter)
                    if (tupla[1] == caracter)
                        if(caracter not in diccionario)
                        diccionario[caracter] = []
                        end
                    diccionario[caracter] = combinarListas(diccionario[caracter], tupla[2])
                    
                    end            
            end
        end
    end
