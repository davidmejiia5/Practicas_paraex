
Node = Struct.new(:value, :next, :prev)

class Alimento
	include Comparable
	attr_accessor :nom, :pro, :car, :lip, :gei, :trr

	def initialize(n,p,c,l,g,t)
		@nom = n 
		@pro = p
		@car = c
		@lip = l
		@gei = g
		@trr = t
	end	

	def get_nom
		return @nom
	end

	def get_gei
		return @gei
	end	

	def get_trr
		return @trr
	end

	def to_s
		"#{@nom},#{@pro},#{@car},#{@lip},#{@gei},#{@trr}"
	end

	def valor_energetico
		return (@pro+4)+(@car+4)+(@lip+9)
	end
	
	def <=>(toCompare)
		valor_energetico <=> toCompare.valor_energetico
	end
end

class Lista
	include Enumerable
	attr_accessor :size, :head, :tail

	def initialize()
		@size = 0
		@head = Node.new(nil,nil,nil)
		@tail = Node.new(nil,nil,nil)
	end

	def push(x)
		n = Node.new(x,nil,nil)
		if(@size == 0)
			@tail = n
			n.next = nil
		else
			@head.prev = n
			n.next = @head
		end
		@head = n
		n.prev = nil
		@size = @size + 1
	end

	def pop_head
		if(@size == 0)
			puts "Lista vacia"
		else
			drop = @head.value
			(@head.next).prev = nil
			@head = @head.next 
			@size = @size - 1
			return drop
		end
	end

	def pop_tail
		if(@size == 0)
			puts "Lista vacia"
		else
			drop = @tail.value
			(@tail.prev).next = nil 
			@tail = tail.prev
			@size = @size - 1
			return drop
		end
	end

	#def to_s 
	#	n= @head
	#	v = Array.new
	#	while(n != nil)
	#		v.push((n.value).nom)
	#		n.next
	#	end
	#	v.to_s
	#end
	
	def each 
		n = @head
		while(n != nil)
			yield n.value
			n = n.next
		end
	end
end

class Plato
	include Comparable
	include Enumerable
	attr_accessor :n_plato, :List_ali, :List_gr
	
	def initialize(nombre)
		@n_plato = nombre
		@List_ali = Lista.new
		@List_gr = Lista.new
	end

	def push_ali(ali)
		@List_ali.push(ali)
	end

	def push_gr(gr)
		@List_gr.push(gr)
	end

	def get_proteinas
		it1 = 0
		it2 = 0
		p = 0
		@List_gr.each do |x|
			gr = x
			it1 += 1
			@List_ali.each do |y|
				it2 += 1
				if(it1 == it2)
					p += gr*y.pro/100
				end
			end
			it2 = 0
		end
		total = 0
		@List_gr.each do |x|
		       total += x
		end
 		p = (p*100)/total
		return p
	end

	def get_lipidos
                it1 = 0
                it2 = 0
                l = 0
                @List_gr.each do |x|
                        gr = x
                        it1 += 1
                        @List_ali.each do |y|
                                it2 += 1
                                if(it1 == it2)
                                        l += gr*y.lip/100
                                end
                        end
                        it2 = 0
                end
                total = 0
                @List_gr.each do |x|
                       total += x
                end
                l = (l*100)/total
                return l
        end

	def get_hidratos
                it1 = 0
                it2 = 0
                h = 0
                @List_gr.each do |x|
                        gr = x
                        it1 += 1
                        @List_ali.each do |y|
                                it2 += 1
                                if(it1 == it2)
                                        h += gr*y.car/100
                                end
                        end
                        it2 = 0
                end
                total = 0
                @List_gr.each do |x|
                       total += x
                end
                h = (h*100)/total
                return h
        end

	def vct
		total = 0
		@List_gr.each do |x|
			total += x
		end
		pro = (get_proteinas*total)/100
		lip = (get_lipidos*total)/100
		h = (get_hidratos*total)/100
		return ((pro*4)+(lip*9)+(h*4))
	end

	def to_s
		alimentos = "El plato esta formado por: " 
		@List_ali.each do |element|
			alimentos = alimentos + element.nom
			alimentos = alimentos + " "
		end
		return alimentos
	end

	def each 
		@List_ali.each
	end

	def <=>(otro)
		vct <=> otro.vct
	end

end


class Ambiental < Plato
	
	include Comparable
	
	def get_co2
                it1 = 0
                it2 = 0
                co2 = 0
                @List_gr.each do |x|
                        gr = x
                        it1 += 1
                        @List_ali.each do |y|
                                it2 += 1
                                if(it1 == it2)
                                        co2 += gr*y.gei/100
                                end
                        end
                        it2 = 0
                end
                return co2
        end

	def get_terreno
                it1 = 0
                it2 = 0
                terr = 0
                @List_gr.each do |x|
                        gr = x
                        it1 += 1
                        @List_ali.each do |y|
                                it2 += 1
                                if(it1 == it2)
                                        terr += gr*y.trr/100
                                end
                        end
                        it2 = 0
                end
                return terr
        end
	
	def imp_energia
		if( get_co2 < 670)
			return 1
		elsif(get_co2 < 830)
			return 2
		end
		return 3
	end

	def imp_carbono
		if( vct < 800)
			return 1
		elsif ( vct < 1200)
			return 2
		end
		return 3
	end

	def huella_nutricional
		return (imp_energia + imp_carbono)/2
	end


	def to_s
		salida = "Cantidad de CO2: "
		salida = salida + get_co2.to_s
		salida = salida + "Cantidad de terreno: "
		salida = salida + get_terreno.to_s
		return salida
	end
	
	def incremento(p)
		p.collect{ |x| x * huella_nutricional}
	end

	def <=>(sida)
		huella_nutricional <=> sida.huella_nutricional
	end
end


