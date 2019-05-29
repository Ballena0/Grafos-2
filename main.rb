#!/usr/bin/env ruby

menuPath = __dir__ + '\Menu.rb'

require menuPath


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
            puts "En caso de querer añadir una transición vacía, ingrese un ampersand (&)"
            tran = gets.chomp
            puts "hasta el estado"
            ef = gets.chomp
            @L[key]= {
                tran.to_s => ef.to_s
            }
            # @L[key].merge!({ tran.to_s => ef.to_s })
            puts "¿Desea añadir otra transición al estado? 1 : si, 0 : no"
            @opt = gets.chomp
            while (@opt.to_i==1)
                puts "Transición del estado" + key + ""
                puts "En caso de querer añadir una transición vacía, ingrese un ampersand (&)"
                tran = gets.chomp
                puts "hasta el estado"
                ef = gets.chomp
                @L[key].merge!({ tran.to_s => ef.to_s })
                puts "¿Desea añadir otra transición al estado? 1 : si, 0 : no"
                @opt = gets.chomp
            end
        end
        puts "Lenguaje del autómata"
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
        puts "Estado inicial del automata"
        @S={}
        @kpt=0
        puts "Los estados del automata son:"
        @K.each do |key,value|
            puts "Estado '" + key + "'"
        end
        puts "Ingrese un estado como inicial"
            @initialState = gets.chomp 
            while (@K.has_key?(@initialState)==0)
                puts "Ingrese un estado perteneciente al autómata"
                @initialState = gets.chomp
            end
            @S[@initialState] = nil
        
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
        @Quintupla[:E]=@E           #Lenguaje 
        @Quintupla[:K]=@K           #Estados
        @Quintupla[:L]=@L           #Transiciones
        @Quintupla[:S]= @S          #Estado Inicial
        @Quintupla[:F]= @F          #Estado final
        puts "la quintupla es :"  
        puts @Quintupla
        tabla = procesaTabla()
        print(tabla)
        @S.each do |nodo,nill|
            print('si entra')
            print(AFD(tabla,@L,nodo,@E))
        end
    end

    def mainMenu
        menu = Menu.new
        menu.mostrar_menu
        menu.opciones
    end

    def vacios(transitions,initialState,nodoInicial)
        transitions.each do |key,value|
            if(key==initialState)
                value.each do |key2,value2|
                    if (key2=='&')
                        nodoInicial.push(value2)                        
                        @resp = vacios(transitions,value2,nodoInicial)
                        if((nodoInicial==@resp)==false)
                            nodoInicial.push(@resp)
                        end
                    end
                end
            end
        end
        return nodoInicial
    end

    def nombreNodo(arrayNodos)
        aux=''
        arrayNodos.each do |e|
            aux += e
        end
        return aux
    end 
    def procesaAFD(nodoInicial,afnd,tabla)

        nombreNodo = nombreNodo(nodoInicial) #Los deja en un string bonito y gordito
        tabla[nombreNodo] = nil
        nodoInicial.each do |elemento|
            afnd.each do |key,value|
                if (key==elemento)
                    value.each do |key2,value2|
                        nodos = []
                        print("key2",key2)
                        print("value2",value2)
                        if (tabla.has_key?(key2)==false)
                            tabla[nombreNodo] = {key2 => value2}
                        end
                        tabla[nombreNodo].merge!({key2 => value2})
                        puts(key)
                        puts(value)
                        value2.each do |key3,value3|
                            nodos.push(key3)
                        end
                        nombreNodo = nombreNodo(nodos)
                        print(nombreNodo)
                        if (tabla.has_key?(nombreNodo)==false)
                            # procesaAFD(tabla[nodos],afnd,tabla) 
                        end
                        # nombreNodo = nombreNodo(value[value2])   
                    end
                end
            end
        end
        return tabla
    end
    def AFD (afnd,transitions,initialState,alph)
        tabla =  {}
        nodoInicial = []
        nodoInicial.push(initialState)
        vacios(transitions,initialState,nodoInicial)
        # nodoInicial.push(vacios(transitions,initialState)) #Obtiene un array de nodos iniciales
        print(nodoInicial)
        procesaAFD(nodoInicial,afnd,tabla)
        return tabla
    end

    def procesaTabla()
        tabla2 = {}
        @K.each do |key,value|
            aux = creaVinculos(@L,@E,key)
            tabla2[key] = aux
        end
        return tabla2
    end
    def creaVinculos(transitions,alph,nodo)
        @vinculos = {}
        transitions.each do |key,value|
            if (key==nodo)
                value.each do |key2,value2|
                    if (key2=='&')
                        aux = creaVinculos(transitions,alph,value2)
                        alph.each do |leng,valueleng|
                            puts leng,value2
                            if (@vinculos[leng])
                                @vinculos[leng].merge!({value2 =>nil})
                            else
                                @vinculos[leng] = {value2 => nil}
                            end

                        end
                        aux.each do |key3,value3|
                            value3.each do |key4,value4|
                                if (@vinculos.has_key?(key3))
                                    @vinculos[key3].merge!({key4 => nil})
                                else
                                    @vinculos[key3] = {key4 => nil}
                                end
                            end
                        end
                    elsif ((@vinculos.has_key?(key2))==false)
                        @vinculos[key2] = {value2 => nil}
                    else 
                        # puts @vinculos.has_key?(key2)==false
                        @vinculos[key2].merge!({value2 => nil})
                        vacios = vacios(transitions,value2)
                        @vinculos[key2].merge!({vacios => nil})
                    end
                end
            end
        end
        return @vinculos
    end



end


quintupla = Application.new