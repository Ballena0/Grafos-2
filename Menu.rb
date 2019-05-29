#!/usr/bin/env ruby

class Menu

    def initialize 
        @exit = false
    end

    def mostrar_menu
        puts "1) Ingrese palabras para saber si pertenecen al lenguaje del automata"
        puts "2) Obtener AFD equivalente (Automata= AFND)"
        puts "3) Simplificar AFD obtenido anteriormente"
        puts "4) Estado intermedio a reducir/eliminar y mostrar la expresión regular resultante (deshabilitada)"
        puts "5) Salir"
        print "Opcion: "
    end

    def opciones
        opc = gets.chomp.to_i.abs
        case opc
            when 1 then
                puts "metodo pertenece_lenguaje(K)"
            when 2 then
                "metodo obtener afd equivalente(Sumatoria_estados_AFND)"
            when 3 then
                "metodo simplificar afd equivalente(AFD_equivalente)"
            when 4 then
                "metodo que muestra estado intermedio a reducir/eliminar y ....(Estados)"
            when 5 then
                @exit = true
        end

    end
    
end

=begin menu = menu.new         

until menu.exit
    menu.mostrar_menu
    menu.opciones
    puts "\n"
=end 
