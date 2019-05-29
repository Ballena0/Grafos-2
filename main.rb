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
        puts "1) *****Estados del autómata*****"
        @contador=0
        @K = {}
        while (@kpt!=1)
            @contador+=1
            puts "Nombre del estado "+ @contador.to_s + ":"
            @nom = gets.chomp
            @K[@nom] = nil
            puts "¿Desea agregar otro estado? 1: SI , otro valor: NO"
            opt = gets.chomp.to_s
            if (opt.to_s!="1") 
                @kpt=1
            end
        end 
        puts "Los estados ingresados son los siguientes"
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        puts "2) *****Lenguaje del autómata*****"
        @E={}
        while (true)
            puts "Ingrese 1 caracter por vez"
            @caracter = gets.chomp
            @E[@caracter] = nil
            puts "¿Desea agregar otro elemento del lenguaje? 1: SI , otro valor: NO"
            opt = gets.chomp 
            if (opt.to_s!="1") 
                break
            end 
        end 
        puts "3) *****Transiciones del autómata*****"
        puts "A continuación ingrese las transiciones respectivas"
        puts "En caso de querer añadir una transición vacía, ingrese un ampersand (&)"
        @L = {}
        @kpt=0
        @aux=[]
        @K.each do |key,value|
            @aux.push(key.to_s)
        end
        @aux.each do |elemento|
            while (true) #while para validar si la transicion existe en el lenguaje 
                puts "Transición del estado" + elemento + ""
                tran = gets.chomp
                @E.each do |key,value|
                    if (key.to_s==tran.to_s)
                        @kpt=1
                    end
                end
                if (@kpt==1)
                    break
                end
                puts "No existe el elemento en el lenguaje. Intente otra vez..."
            end
            @kpt=0
            while (@kpt!=1) #while para validar datos
                puts "Estado destino(debe existir): "
                ef = gets.chomp
                @K.each do |key,value|
                    if (key.to_s==ef.to_s)
                        @kpt=1
                    end 
                end
            end
            @L[elemento]= {
                tran.to_s => ef.to_s
            }
            # @L[key].merge!({ tran.to_s => ef.to_s })
            puts "¿Desea añadir otra transición al estado? 1 : SI, otro valor : NO"
            puts "En caso de querer añadir una transición vacía, ingrese un ampersand (&)"
            @opt = gets.chomp
            while (@opt.to_s=="1")
                while (true) #while para validar si la transicion existe en el lenguaje 
                    puts "Transición del estado" + elemento + ""
                    tran = gets.chomp
                    @E.each do |key,value|
                        if (key.to_s==tran.to_s)
                            @kpt=1
                        end
                    end
                    if (@kpt==1)
                        break
                    end
                    puts "No existe el elemento en el lenguaje. Intente otra vez..."
                end
                @kpt=0
                while (@kpt!=1) #while para validar datos
                    puts "Estado destino(debe existir): "
                    ef = gets.chomp
                    @K.each do |key,value|
                        if (key.to_s==ef.to_s)
                            @kpt=1
                        end
                    end
                end
                @L[elemento]= {
                    tran.to_s => ef.to_s
                }
                @L[elemento].merge!({ tran.to_s => ef.to_s })
                puts "¿Desea añadir otra transición al estado? 1 : SI, otro valor : NO"
                puts "En caso de querer añadir una transición vacía, ingrese un ampersand (&)"
                @opt = gets.chomp
            end
        end
        puts "4) *****Estado inicial del automata*****"
        @S={}
        puts "Los estados del automata son:"
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        puts "Ingrese un estado como inicial: "
        @initialState = gets.chomp 
        while (@K.has_key?(@initialState)==0)
            puts "Ingrese un estado perteneciente al autómata"
            @initialState = gets.chomp
        end
        @S[@initialState] = nil
    
        puts "5) *****Estado(s) final(es) del automata*****"
        @F={}
        @kpt=0
        puts "Los estados del automata son:"
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        while (@kpt!=1)
            puts "Ingrese un estado como final:"
            @finalState = gets.chomp 
            while (@K.has_key?(@finalState)==0)
                puts "Ingrese un estado perteneciente al autómata"
                @finalState = gets.chomp
            end
            @F[@finalState] = nil
            puts "¿Desea agregar otro estado final? 1 : SI, otro valor : NO"
            opt = gets.chomp 
            if (opt.to_s!="1") 
                @kpt=1
            end 
        end
        @K['S']= nil
        @Quintupla[:E]=@E           #Lenguaje 
        @Quintupla[:K]=@K           #Estados
        @Quintupla[:L]=@L           #Transiciones
        @Quintupla[:S]= @S          #Estado Inicial
        @Quintupla[:F]= @F          #Estado final
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