#!/usr/bin/env ruby



class Application

    attr_accessor :Quintupla
    def initialize
        @Quintupla = {
            
        }
        automata
        mainMenu
    end
    def automata()
        puts "Antes de ingresar a la aplicación de afd-afnd se debe ingresar la quintupla correspondiente."
        puts "Quintupla correspondiente"
        puts "1) Estados del autómata"
        @contador=0
        @K = {}
        while (@kpt!=1)
            @contador+=1
            puts "Nombre del estado "+ @contador.to_s + ":"
            @nom = gets.chomp
            @K[@nom] = nil
            puts "¿Desea agregar otro estado? 1: si , 0: no"
            opt = gets.chomp 
            if (opt.to_i==0) 
                @kpt=1
            end 
        end 
        puts "2) Transiciones del autómata"
        puts "Los estados ingresados son los siguientes"
        @kpt=0
        @L = {}
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        puts "A continuación ingrese las transiciones respectivas"
        @K.each do |key,value|
            puts "Transición del estado" + key + ""
            tran = gets.chomp
            puts " hasta el estado"
            ef = gets.chomp
            @L[key]= {
                tran.to_s => ef.to_s
            }
            # @L[key].merge!({ tran.to_s => ef.to_s })
            puts "¿Desea añadir otra transición al estado? 1 : si, 0 : no"
            @opt = gets.chomp
            while (@opt.to_i==1)
                puts "Transición del estado" + key + ""
                tran = gets.chomp
                puts "hasta el estado"
                ef = gets.chomp
                @L[key].merge!({ tran.to_s => ef.to_s })
                puts "¿Desea añadir otra transición al estado? 1 : si, 0 : no"
                @opt = gets.chomp
            end
        end
        puts "Diccionario del autómata"
        @E={}
        @kpt=0
        while (@kpt!=1)
            puts "Ingrese 1 caracter por vez"
            @caracter = gets.chomp
            @E[@caracter] = nil
            puts "¿Desea agregar otro caracter? 1: si , 0: no"
            opt = gets.chomp 
            if (opt.to_i==0) 
                @kpt=1
            end 
        end 
        puts "Estados iniciales del automata"
        @S={}
        @kpt=0
        puts "Los estados del automata son:"
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        while (@kpt!=1)
            puts "Ingrese un estado como inicial"
            @initialState = gets.chomp 
            while (@K.has_key?(@initialState)==0)
                puts "Ingrese un estado perteneciente al autómata"
                @initialState = gets.chomp
            end
            @S[@initialState] = nil
            puts "¿Desea agregar otro estado inicial? 1: si , 0: no"
            opt = gets.chomp 
            if (opt.to_i==0) 
                @kpt=1
            end 
        end
        
        puts "Estado final del automata"
        @F={}
        @kpt=0
        puts "Los estados del automata son:"
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        while (@kpt!=1)
            puts "Ingrese un estado como final"
            @finalState = gets.chomp 
            while (@K.has_key?(@finalState)==0)
                puts "Ingrese un estado perteneciente al autómata"
                @finalState = gets.chomp
            end
            @F[@finalState] = nil
            puts "¿Desea agregar otro estado final? 1: si , 0: no"
            opt = gets.chomp 
            if (opt.to_i==0) 
                @kpt=1
            end 
        end
        @K['S']= nil
        @Quintupla[:E]=@E
        @Quintupla[:K]=@K
        @Quintupla[:L]=@L
        @Quintupla[:S]= @S
        @Quintupla[:F]= @F
        puts "la quintupla es :"  
        puts @Quintupla
    end

    def mainMenu
        puts "nothing yet"
    end
end





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
    return @listaFinal
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
    for tupla in @lista 
        if (nodo == tupla[0])
            for caracter in @alfabeto
                if (tupla[1] == caracter)
                    if (tupla[1] == caracter)
                        if(diccionario.has_key? "caracter")
                            diccionario[caracter] = []
                        end
                    diccionario[caracter] = combinarListas(diccionario[caracter], tupla[2])
                    diccionario[caracter]= combinarListas(diccionario[caracter], conexionesConVacio(lista, tupla[2]))
                    end
                end 
            if (tupla[1] == "")
                aux = procesarNodo(lista, alfabeto, tupla[2])
                for c,e in @aux.to_a()
                    if (diccionario.has_key? "c") 
                        diccionario[c] = combinarListas(diccionario[c], e)
                    else
                        diccionario[c] = []
                        diccionario[c] = combinarListas(diccionario[c], e)
                    end
                end
            end        
        end
        return diccionario
    end
end
end

Application.new