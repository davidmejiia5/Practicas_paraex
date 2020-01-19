RSpec.describe P6Ex do

	before (:all) do 

		@carne= Alimento.new("carne",21.1,0.0,3.1,50.0,164.0)
                @cordero = Alimento.new("cordero",18.0,0.0,3.1,50.0,164.0)
                @camarones = Alimento.new("camarones",17.6,1.5,0.6,18.0,2.0)
                @chocolate = Alimento.new("chocolate",5.3,47.0,30.0,2.3,3.4)
                @salmon = Alimento.new("Salmon",19.9,0.0,13.6,6.0,3.7)
                @cerdo = Alimento.new("cerdo",21.5,0.0,6.3,7.6,11.0)
                @pollo = Alimento.new("pollo",20.6,0.0,5.6,5.7,7.1)
                @queso = Alimento.new("queso",25.0,1.3,33.0,11.0,41.0)
                @cerveza = Alimento.new("caña",0.5,3.6,0.0,0.25,0.22)
                @leche = Alimento.new("leche",3.3,4.8,3.2,3.2,8.9)
                @huevo = Alimento.new("huevos",13.0,1.1,11.0,4.2,5.7)
                @cafe = Alimento.new("cafe",0.1,0.0,0.0,0.4,0.3)
                @tofu = Alimento.new("tofu",8.0,1.9,4.8,2.0,2.2)
                @lentejas = Alimento.new("lentejas",23.5,52.0,1.4,0.4,3.4)
                @nuez = Alimento.new("nuez",20.0,21.0,54.0,0.3,7.9)
		#Generando la lista
		@List = Lista.new
		#Generando el plato
		@Plato = Plato.new("Puchero")
		@Plato.push_ali(@carne)
		@Plato.push_gr(300)
		@Plato.push_ali(@cerdo)
		@Plato.push_gr(250)
		@Plato1 = Plato.new("caca")
		@Plato1.push_ali(@pollo)
		@Plato1.push_gr(300)
		@Plato1.push_ali(@queso)
		@Plato1.push_gr(100)
		#Creando el plato ambiental
		@Ambiente = Ambiental.new("PlatoAmbiental")
		@Ambiente.push_ali(@carne)
		@Ambiente.push_gr(100)
		@Ambiente.push_ali(@cerdo)
		@Ambiente.push_gr(500)
		#Dieta Española
		@Locos_carne = Lista.new
		@Locos_carne.push(@Plato)
		@Locos_carne.push(@Plato1)
	end

	context "Debe existir"do 
		it "Un nombre para cada plato" do
			expect(@carne.nom).not_to eq(nil) 
		end
		it "la cantidad de emision de gases"do 
			expect(@carne.gei).to eq(50.0)
		end
		it "la cantidad de terreno utilizado"do 
			expect(@carne.trr).to eq(164.0)
		end
	end
	context "Existe un metodo para obtener" do 
		it "El nombre del alimento" do
			expect(@carne.get_nom).to eq("carne")	
		end
		it "las emisiones de gases" do 
			expect(@carne.get_gei).to eq(50.0)
		end
		it "el terreno utilizado" do
			expect(@carne.get_trr).to eq(164)
		end
		it "el alimento formateado" do 
			expect(@carne.to_s).to eq("carne,21.1,0.0,3.1,50.0,164.0")
		end
		it "el valor energetico"do 
			expect(@carne.valor_energetico).to eq(41.2)
		end
	end
	context "Comprobando funcionalidades de la lista"do 
		it "Comprobamos nodo"do 
			@List.push(@carne)
			expect((@List.head).value).to eq(@carne)
		end
		it "Existe una cabeza"do 
			expect((@List.head).value).to eq(@carne)
		end
		it "Existe una cola" do 
			expect((@List.tail).value).to eq(@carne)
		end
		it "Se pueden insertar varios elementos en la lista" do 
			@List.push(@cerveza)
			expect(@List.size).to eq(2)
		end
		it "Podemos extraer un elemento por la cabezera"do 
			eliminado = @List.pop_head
			expect(eliminado).to eq(@cerveza)
		end
		it "Podemos extraer un elemento por la cola"do 
			@List.push(@carne)
			eliminado = @List.pop_tail
			expect(eliminado).to eq(@carne)
		end
	end
	context "Mas pruebas"do 
		it "Funciona el comparable"do 
			expect(@carne == @carne).to eq(true)
		end
		it "Funciona el min"do
		        @List.push(@cerveza)
			@List.push(@cerdo)	
			expect(@List.min).to eq(@cerveza)
		end
		it "Funciona el each"do 
			expect(@List.count).to eq(3)
		end
		it "Funciona el max" do 
			expect(@List.max).to eq(@cerdo)
		end
		it "Funciona el collect" do 
			expect(@List.collect{|x| x.nom + "X"}).to eq([@cerdo.nom,@cerveza.nom,@carne.nom])
		end
	end	
	context "Probando la clase plato" do
		it "Existe un nombre para el plato"do 
			expect(@Plato.n_plato).to eq("Puchero")
		end
		it "Existe un conjunto de alimentos"do 
			expect(@Plato.List_ali.count).to eq(2)
		end
		it "Existe un conjunto de gramos"do 
			expect(@Plato.List_gr.count).to eq(2)
		end
		it "Porcentaje de proteinas de un conjunto de alimentos"do 
			expect(@Plato.get_proteinas).to eq(21.28181818181818)
		end
		it "Porcentaje de lipidos el conjunto de alimentos"do 
			expect(@Plato.get_lipidos).to eq(4.554545454545455)
		end
		it "Porcentaje de hidratos" do 
			expect(@Plato.get_hidratos).to eq(0.0)
		end
		it "Caldular el VCT"do 
			expect(@Plato.vct).to eq(693.65)
		end
		it "Puede obtenerse el plato formateado" do 
			expect(@Plato.to_s).to eq("El plato esta formado por: cerdo carne ")
		end
	end
	context "Comprobamos la clase ambiente" do 
		it"Valor total de emisiones diarias de efecto invernadero"do 
			expect(@Ambiente.get_co2).to eq(88)
		end
		it "Cantidad de terreno usada" do 
			expect(@Ambiente.get_terreno).to eq(219)
		end
		it "Ambiente formateado"do 
			expect(@Ambiente.to_s).to eq("Cantidad de CO2: 88.0Cantidad de terreno: 219.0")
		end
		it "Nombre de la clase"do 
			expect(@Ambiente.class).to eq(Ambiental)
		end
	end
	context "Comprobamos las dietas y su funcionamiento" do 
		it "Funciona el comparable " do 
			expect(@Locos_carne == @Locos_carne).to eq(true)
		end
		it "Funciona el min" do 
			expect(@Locos_carne.min).to eq(@Plato)
		end
		it "Funciona el max" do 
			expect(@Locos_carne.max).to eq(@Plato1)
		end
	end
end
