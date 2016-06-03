#Procedimientos del gerente*********************************************

#Consultar inventarios---------------
drop procedure if exists inventario; #CCCCCCCCCCCCCC
delimiter  $$
create procedure inventario(bod_id int)
	begin
			select idProducti as id, pro_name as Referencia, pro_precioVenta as precio, pro_talla as Talla, cantidad from product_has_bodega join product on Product_idProducti = idProducti where Bodega_idBodega = bod_id order by idProducti;
	end;
$$
delimiter ;
call inventario(3);
#Consultar inventarios---------------

select * from persona;

drop procedure if exists ActualizarCantidadBodegas;
delimiter $$
create procedure ActualizarCantidadBodegas(idPro int , idBod int, cant int)
begin
	update product_has_bodega set cantidad=cant where  product_idProducti=idPro and Bodega_idBodega=idBod;
end;
$$
delimiter ;

call ActualizarCantidadBodegas(3,1,10);

select * from product_has_bodega;

#Agregar nuevos productos--------------------------
#idProducto , idBoega, cantidad
call actualiza(1,1,15);   #CCCCCCCCCCCCCC
# Se actualizara el inventario correspodiente al producto 9 de la bodega 2 en 26 unidades
# se puede pasar un argumento con valor negativo indicando la ida del producto
#Argegar nuevos productos----------------------------------

select pro_name,nombre,cantidad from product_has_bodega join product on Product_idProducti=idProducti join bodega on Bodega_idBodega=idBodega;

select * from product_has_bodega;

#Generar nuevo madrugon --------------------------------
#Basta con llamar al procedimiento insertarMercado con la fecha este se encargará de ver cual fue el anterior y hacer la orrespondencia
call insertarMercado(curdate());
#Generar nuevo madrugon --------------------------------

drop procedure if exists tablaMercado;
delimiter :*
create procedure tablaMercado(idMercado int)
begin
	set @aux = -1; set @aux = (select mer_id from mercado where mer_id = idMercado);
	if(@aux != -1) then
		select idMercadoHasProduct,pro_name,cantidad_inicial,cantidad_agregada,(cantidad_inicial+cantidad_agregada) as total ,cantidad_final,  
		(cantidad_inicial+cantidad_agregada-cantidad_final) as sells , (cantidad_inicial+cantidad_agregada-cantidad_final)*pro_precioVenta 
		as money from Product join MercadoHasProduct on Product_idProducti=idProducti join mercado on mercado.mer_id=MercadoHasProduct.Mercado_mer_id
		where mer_id = idMercado;
	else 
		select 'Mercado no encontrado' as error;
	end if;
end;
:*
delimiter ;

call tablaMercado(6);

drop procedure if exists mercadoFecha;
delimiter :*
create procedure mercadoFecha(myfecha date)
begin
	set @aux = -1;
	select mer_id from mercado where fecha = myfecha limit 1 into @aux;
	if(@aux = -1) then
		select 'No se encontro mercado en esa fecha, por favor verifiquelo e intente nuevamente';
	else
		call tablaMercado(@aux);
	end if;
end;
:*
delimiter ;

#update mercadoHasProduct set cantidad_final = 0 where Mercado_mer_id = 5 and cantidad_inicial = 0;

call mercadoFecha('2014/12/08');

#select * from mercado;
#select * from bodega;
#Remision---------------------
# 1 crear una remision pasando los id's de las bodegas
call nuevaRemision(3,1);

select * from remision;

# 2 insertar cada uno de los detalles de ell
call insertarDetalleRemision(7,35,25);
call insertarDetalleRemision(1,23,58);
call insertarDetalleRemision(1,35,63);
call insertarDetalleRemision(1,90,25);
call insertarDetalleRemision(1,65,9);
call insertarDetalleRemision(1,92,66);
call insertarDetalleRemision(1,89,41);
call insertarDetalleRemision(1,39,28);
call insertarDetalleRemision(1,32,37);
call insertarDetalleRemision(1,51,65);
#.
#.
#.

select * from DetalleRemision;


##Remision------------------------

#Consultar mejores clientes-------------------------------------
drop procedure if exists bestClients;
delimiter $$
create procedure bestClients()
	begin
		select * from mostCurrent;
	end;
$$
delimiter ;

call bestClients();
#Consultar mejores clientes-------------------------------------



#Consultar proveedores-------------------------------------
drop procedure if exists consultProveedores;
delimiter $$
create procedure consultProveedores()
	begin
		select * from proveedores;
	end;
$$
delimiter ;

call consultProveedores();
#Consultar proveedores-------------------------------------

#Realizar pedidos----------------------------------

#Llamar a insertarRegistroProvee con el id del rollo y el id del proveedor
call insertarRegistroProvee(2,68);


#Realizar pedidos--------------------------------

#Cambiar los precios-------------------------------------
#Procedure , donde dado un valor (price) y un producto( varchar(30)) se actualiza la tabla producto

SET SQL_SAFE_UPDATES = 0;

drop procedure if exists changePriceProduct;
delimiter $$
create procedure changePriceProduct( price int, namet varchar(30))
	begin
		update product set pro_precioVenta=price where pro_name=namet;
	end ;
$$
delimiter ;

select * from product ;

call changePriceProduct(11500,'fgdfgdf');
#Cambiar los precios--------------------------------------


#Procedimientos del gerente*********************************************


################################################################################################################################################
#Procedimientos del cliente********************************************************************************************************************

select * from product;

select idProducti from product where pro_name='PTS';
select idBodega from bodega where nombre='central';
select * from product_has_bodega;


drop procedure if exists buyProduct;
delimiter :*
create procedure buyProduct( cnt int, idbodegat int, idcli int, idemp int,  idprod int )
	begin
	
		start transaction;
		set @pointsAux=-1;
		set @pointsAuxNew=-1;

		set  @aux= -1; 
		set @aux =( select Product_has_Bodega.cantidad FROM Product join Product_has_Bodega on Product_idProducti=idProducti 
						where Bodega_idBodega=idbodegat and idProducti=idprod);
		set @product = -1;
		set @product = (select idprod from product where idProducti = idprod);
		set @clientepp=-1; 
		set @clientepp = (select per_id FROM cliente where per_id=idcli);
		set @empleadopp= -1; 
		set @empleadopp = ( select  per_id FROM empleado where per_id=idemp);
		set @bodegapp = -1;
		set @bodegapp = (select idBodega from bodega where idBodega=idbodegat);
		
		

		if(@clientepp != -1 and @empleadopp != -1 and @bodegapp!=-1 and @product != -1) then
			if(@aux<cnt) then
				select 'NO se pueden comprar esa cantidad de productos porque no hay suficientes' as message;
			else 
				
				

				SAVEPOINT A;
				insert into venta(ven_fecha,Cliente_per_id,Empleado_per_id,Bodega_idBodega) values(curdate(), @clientepp,@empleadopp,@bodegapp);
				set @aux = (select ven_id from venta order by ven_id desc limit 1);
				insert into detalleventa (cantidad,Venta_ven_id,Product_idProducti) values (cnt,@aux,idprod);
				
				set @pointsAuxNew= 0;
				select cantidad into @pointsAuxNew from Product_has_Bodega where Product_idProducti= idprod and Bodega_idBodega=@bodegapp limit 1;#

				update Product_has_Bodega set cantidad=cantidad-cnt where Product_idProducti= idprod and Bodega_idBodega=@bodegapp;
				set @valor = cnt;
				set @valor = @valor * (select pro_precioVenta from product where idProducti = idprod);

				set @pointsAux= 0 ;
				select cantidad into @pointsAux from Product_has_Bodega where Product_idProducti= idprod and Bodega_idBodega=@bodegapp limit 1;

				update cliente set puntos = puntos+(@valor/1000) where per_id = idcli;
				

				if( @pointsAux=@pointsAuxNew) then#
					rollback to savepoint A;#
				end if ;#

				select concat('Compra concretada correctamente por valor de: ',@valor) as mensaje;

				commit;#
			end if ;
		elseif (@clientepp = -1) then 
			select 'Cliente no existe' as Error;
		elseif(@empleadopp=-1) then
			select 'Empleado no existe' as Error;
		elseif(@bodegapp=-1) then
			select 'Bodega no existe' as Error;
		else 
			select @product,@clientepp,@empleadopp,@bodegapp;
			select 'Producto no existe' as Error;
		end if;
	end ;
:*
delimiter ;


select * from product_has_bodega;
call inventario(1);
select * from cliente;
#cantidad,bodega,cliente,empleado,producto
call buyProduct(2,1,1,54,1);
call buyProduct(6,1,64,54,48);
select * from venta;
select * from detalleventa where Venta_ven_id = 38;


select per_id,per_name from cliente join persona using(per_id) ;


select * from persona;

select * from cliente join persona using(per_id);

# user : 10009937
# contraseña: 2884


# user: 10000824
# cos :28514

# user: 10004099
# cod :30927

select pro_name,nombre,cantidad,pro_precioVenta from product_has_bodega join product on Product_idProducti=idProducti join bodega on Bodega_idBodega=idBodega;


select  per_id  from persona where per_cedula= 10003345 limit 1;

#  producto :PTS
#  Bodega :central

select * from product_has_bodega;

select * from empleado join persona using(per_id);


#EMpleado

# 10003345

#Consultar puntos
drop procedure if exists puntos;
delimiter $$
create procedure puntos(cli_id int)
begin
		set @id = -1; set @id = (select per_id from cliente where per_id = cli_id);
		if(@id != -1) then
			set @puntos = (select puntos from cliente where per_id = cli_id);
			select concat(concat('Tu tienes: ',@puntos),' puntos.') as mensaje;
			#select @puntos;
		else 
			select 'Cliente no existe' as error;
		end if;
end;
$$

delimiter ;
select * from cliente;
call puntos(64);

drop procedure if exists puntosCedula;
delimiter :*
create procedure puntosCedula(ced int)
begin
	select puntos from cliente join persona using (per_id) where per_cedula = ced limit 1;
end;
:*
delimiter ;

call puntosCedula(10000824);

select ven_id,ven_fecha,Empleado_per_id,Bodega_idBodega from venta join cliente on per_id = Cliente_per_id where per_id = 1;


drop procedure if exists comprasCompletas;
delimiter :I
create procedure comprasCompletas (cli int)
begin
	declare dven,cantidad,venta int default -1;
	declare nombreProducto,empleado,bodega varchar(30);
	declare fecha date;
	declare done int default 0;
	declare cursorIni cursor for select dven_id,DetalleVenta.cantidad,Venta_ven_id,ven_fecha,pro_name,Bodega.nombre,per_name from DetalleVenta 
									join product on Product_idProducti=idProducti
									join Venta on Venta_ven_id=ven_id join Bodega on Bodega_idBodega=idBodega 
									join cliente on Cliente_per_id=Cliente.per_id
									join empleado on Empleado_per_id=Empleado.per_id join persona on Empleado.per_id=Persona.per_id
										where Cliente.per_id=cli;
	declare continue handler for sqlstate '02000' set done = 1;
	
	open cursorIni;
	repeat	
		fetch cursorIni into dven,cantidad,venta,fecha,nombreProducto,bodega,empleado;
		if( not done ) then
			select dven,cantidad,venta,fecha,nombreProducto,bodega,empleado;
		end if;
	until done end repeat;
	close cursorIni;
end;
:I
delimiter ;

call comprasCompletas(1);

#################################################
#Cursores

drop procedure if exists RemisionesCompletas;
delimiter :I
create procedure RemisionesCompletas (idBodr int )
begin
	declare dRem,dremi,cantidad,precio int default -1;
	declare nombreProducto, bodega varchar(30);
	declare fecha date;
	declare done int default 0;
	declare cursorIni2 cursor for select idDetalleRemision,idRemision,det_cantidad,det_precio,Remision.rem_fecha,pro_name,Bodega.nombre from
										DetalleRemision join Remision  on Remision_idRemision=idRemision 
											join product on Product_idProducti=idProducti join Bodega on Bodega_idBodega=idBodega where
											Bodega_recibe=idBodr ;
	declare continue handler for sqlstate '02000' set done = 1;
	
	open cursorIni2;
	repeat	
		fetch cursorIni2 into dRem,dremi,cantidad,precio,fecha,nombreProducto,bodega;
		if( not done ) then
			select dRem,dremi,cantidad,precio,fecha,nombreProducto,bodega;
		end if;
	until done end repeat;
	close cursorIni2;
end;
:I
delimiter ;

call RemisionesCompletas(3);

drop procedure if exists comprasCompletas;
delimiter :I
create procedure comprasCompletas (cli int)
begin
	declare dven,cantidad,venta int default -1;
	declare nombreProducto,empleado,bodega varchar(30);
	declare fecha date;
	declare done int default 0;
	declare cursorIni cursor for select dven_id,DetalleVenta.cantidad,Venta_ven_id,ven_fecha,pro_name,Bodega.nombre,per_name from DetalleVenta 
									join product on Product_idProducti=idProducti
									join Venta on Venta_ven_id=ven_id join Bodega on Bodega_idBodega=idBodega 
									join cliente on Cliente_per_id=Cliente.per_id
									join empleado on Empleado_per_id=Empleado.per_id join persona on Empleado.per_id=Persona.per_id
										where Cliente.per_id=cli;
	declare continue handler for sqlstate '02000' set done = 1;
	
	open cursorIni;
	repeat	
		fetch cursorIni into dven,cantidad,venta,fecha,nombreProducto,bodega,empleado;
		if( not done ) then
			select dven,cantidad,venta,fecha,nombreProducto,bodega,empleado;
		end if;
	until done end repeat;
	close cursorIni;
end;
:I
delimiter ;


call comprasCompletas(2);



#Cursores
##################################################


drop procedure if exists compras;
delimiter :*
create procedure compras (completo int,cliente int)
begin
		set @aux = -1; set @aux = (select per_id from cliente where per_id = cliente limit 1);
		if(@aux != -1) then
			if(completo = 0) then
					select ven_fecha as fecha,persona.per_cedula as empleado, Bodega.nombre as bodega from venta join cliente on cliente.per_id = Cliente_per_id
							join empleado on Empleado_per_id=empleado.per_id  join persona on  Empleado_per_id=persona.per_id
							join bodega on Bodega_idBodega=idBodega		where cliente.per_id = cliente;
			else
					call comprasCompletas(@aux);
			end if;
		else 
			select 'Cliente no existe' as error;
		end if;
end;		
:*
delimiter ;

call compras(0,64);




select * from cliente ;


    ####################################################
	#Nuevos procedimientos Clientes 

#consultar si el cliente existe o no

drop procedure if exists ConsultarClientes;
delimiter $$
create procedure ConsultarClientes(idCel long,cont varchar(35))
begin
	
	set @aux=-1;
	set @cons=(select contrasena from cliente join persona where per_cedula=idCel limit 1);
	set @aux=(select per_id  from cliente join persona using(per_id) where per_cedula = idCel limit 1);
	if(@aux !=-1 and cont=@cons) then
		select '1' as consult ;
	else
		select '-1 'as consult;

	
	end if;
end;
$$
delimiter ;

#call ConsultarClientes(10000824,asd); error to see in java

select per_name FROM  persona where per_cedula=10000824 ;

# contraseña: 2884


# user: 10000824
# cos :28514

# user: 10004099
# cod :30927


drop procedure if exists ConsultarEmpleado;
delimiter $$
create procedure ConsultarEmpleado(idCel long,cont varchar(35))
begin
	
	set @aux=-1;
	set @cons=(select contrasena from empleado join persona where per_cedula=idCel limit 1);
	set @aux=(select per_id  from empleado join persona using(per_id) where per_cedula = idCel limit 1);
	if(@aux !=-1 and cont=@cons) then
		select '1' as consult ;
	else
		select '-1 'as consult;	
	end if;
end;
$$
delimiter ;

select per_cedula,contrasena,per_name from empleado join persona using (per_id) ;

#Empleado

# user:10008458
# contraseña :30441

# user:10005951
# contraseña :12333

# user:10003345
# contraseña :3317

#select * from cliente join persona using (per_id);

call ConsultarEmpleado(10008458,'30451');  #error to see in java


select * from persona;

drop procedure if exists SelectIds;
delimiter $$
create procedure SelectIds(proName varchar(35), BodegaName varchar(30))
begin
	select Product_idProducti,Bodega_idBodega  from product_has_bodega join product on Product_idProducti=idProducti join bodega on idBodega=Bodega_idBodega
	  where pro_name=proName and  BodegaName=nombre limit 1;
end;
$$
delimiter ;

select * from persona;

drop procedure if exists getId;
delimiter :)
create procedure getId(ced int)
begin
	set @aux = -1;
	select per_id  from persona where per_cedula= ced limit 1 into @aux;
	select @aux;
end;
:)
delimiter ;

call getId(10000824);

select * from cliente join persona using(per_id);

select  per_id  from persona where per_cedula=10009937 limit 1;

call SelectIds('PTS','central');


select * from bodega;

#  producto :PTS
#  Bodega :central


select pro_name, bodega.nombre,cantidad from product_has_bodega join product on Product_idProducti=idProducti join bodega on Bodega_idBodega=idBodega;

##selecciones para verificar con java

#select * from persona;
#select * from cliente join persona using(per_id);
#select * from cliente;
#select per_id from cliente join persona using (per_id) where per_cedula=10000824;
#select * from cliente join persona using(per_id);
#select puntos from cliente join persona using (per_id) where per_cedula=654321;

###################################
#Proveedor
drop procedure if exists consultarenvios;
delimiter $$
create procedure consultarenvios( envitt int )
	begin
		set @aux=-1;
		select Persona_per_id into @aux from Proveedor where Persona_per_id=envitt;
		if(@aux=-1) then
			select 'No se encontro el Proveedor';
		else 
			select ins_nombre,proveeInsumo.cantidad,idRollo,rol_referencia,rol_peso,rol_longitud,rol_color,rol_precioKilogramo  from 
					proveeInsumo join provee on proveeInsumo.Proveedor_Persona_per_id=provee.Proveedor_Persona_per_id 
					join rollo on Rollo_idRollo=idRollo 
					join insumos  on insumos_idinsumos=idinsumos  where proveeInsumo.Proveedor_Persona_per_id=envitt;
		end if;
	end ;
$$
delimiter ;

select * from proveeInsumo;
select * from rollo;

call consultarenvios(67);


drop procedure if exists consultarCliente;
delimiter :3
create procedure consultarCliente(ced int)
begin
	select per_cedula as cedula, per_name as Nombre,per_direccion as direccion, per_telefono as telefono, puntos, per_antiguedad as antiguedad from cliente join persona using(per_id) where per_cedula = ced;
end;
:3
delimiter ;


drop procedure if exists consultarEmpleadow;
delimiter :3
create procedure consultarEmpleadow(ced int)
begin
	select per_cedula as cedula, per_name as Nombre,per_direccion as direccion, per_telefono as telefono, salario, per_antiguedad as antiguedad from empleado join persona using(per_id) where per_cedula = ced;
end;
:3
delimiter ;

select * from proveedores join persona using(per_id);

drop procedure if exists consultarProveedorw;
delimiter :3
create procedure consultarProveedorw(ced int)
begin
	select * from proveedor join persona on Persona_per_id = per_id where per_cedula = ced;
end;
:3
delimiter ;


call consultarCliente(10000824);


select * from Proveedor;
call consultarenvios(67 );

select * from  proveedores;

select * from bodega;
select * from persona;
select * from empleado join persona using (per_id);




drop procedure if exists getIdMercado;
delimiter :*
create procedure getIdMercado(fec date)
begin
	set @hola = -1;
	select mer_id into @hola from mercado where fecha = fec;
	select @hola;
end;
:*
delimiter ;

drop procedure if exists actualizarMercado;
delimiter :3
create procedure actualizarMercado(bod varchar(30) , producto varchar(30) ,  agregada int , final  int , id int )
begin
	start transaction;
	set @aux = -1;
	set @aux2 = -1;
	set @aux3 = -1;
	set @aux4 = (select cantidad_agregada from mercadohasproduct where idMercadoHasProduct = id);
	 select Product_idProducti,Bodega_idBodega,cantidad  from product_has_bodega join product on Product_idProducti=idProducti join bodega on idBodega=Bodega_idBodega
		where pro_name=producto and  nombre=bod limit 1 into @aux, @aux2,@aux3;
	if(@aux2 = -1) then
		select 'BODEGA NO EXISTE, por favor ingrese una bodega asi solo se desee cambiar la cantidad final o 
			verifique que el nombre este escrito correctamente e intente de nuevo';
	elseif(@aux2 = -1) then
		select 'producto no existe';
	elseif(agregada-@aux4>@aux3) then
		select concat('No se puede actualizar, en la bodega hay disponibles: ',@aux3);
	elseif(final < 0 ) then
		select 'La cantidad final debe ser mayor a 0';
	else 
		call actualiza(@aux,@aux2,@aux4-agregada);
		update mercadohasproduct set cantidad_agregada = agregada, cantidad_final = final where idMercadoHasProduct = id;
		select 'Actualizado con exito';
	end if;
	commit;
end;
:3
delimiter ;

call actualizarMercado('Central','PTL',111,3,143);
call mercadoFecha('2014/12/08');
call inventario(1);

update product_has_bodega set cantidad = 30 where idRegis < 71;


drop procedure if exists consultarRemisiones;
delimiter :*
create procedure consultarRemisiones()
begin
	select idRemision,rem_fecha,remitente,nombre as receptor from (select idRemision,rem_fecha,nombre  as remitente, Bodega_recibe from remision inner join Bodega on Bodega_idBodega = idBodega) as tabla join Bodega on Bodega_recibe = Bodega.idBodega;
end;
:*
delimiter ;

call consultarRemisiones();

drop procedure if exists detalleRemision;
delimiter :*
create procedure detalleRemision(id int)
begin
	select pro_name as producto, det_cantidad as cantidad, det_precio as precioUnitario, det_precio*det_cantidad as subTotal  from detalleremision join product on Product_idProducti = idProducti where Remision_idRemision = id order by idProducti;
end;
:*
delimiter ;

ALTER IGNORE TABLE detalleRemision ADD UNIQUE INDEX(Remision_idRemision,Product_idProducti);

call detalleRemision(1);

select * from detalleRemision;

drop procedure if exists getLastMercado;
delimiter :*
create procedure getLastMercado()
begin
	set @id = (select mer_id from mercado order by mer_id desc limit 1);
	call tablaMercado(@id);
end;
:*
delimiter ; 


drop procedure if exists getLastDate;
delimiter :*
create procedure getLastDate()
begin
	set @id = (select mer_id from mercado order by mer_id desc limit 1);
	select fecha from mercado where mer_id = @id;
end;
:*
delimiter ; 

call getLastDate();


select * from mercado;

call mercadoFecha('2014/12/09');
call getLastMercado();


select * from proveedor;

drop procedure if exists ConsultarProveedor;
delimiter $$
create procedure ConsultarProveedor(cedpro int, passW int)
begin
	set @aux=-1;
	set @aux=(select per_id from proveedor join persona on per_id=Persona_per_id  where per_cedula=cedpro and contrasena=passW );
	if(@aux!=-1)then
		select '1';
	else
		select '-1';
	end if;
end ;
$$
delimiter ;

select per_id from proveedor join persona on Persona_per_id=per_id  where per_cedula=10002094 and contrasena=8130;

select * from proveedor join persona on Persona_per_id=per_id ;

select * from persona;
select * from proveedores;

#proveedor


#user: 10002094
#contrasena:8130


#user:10007073
#contrasena:29279

#user: 10008623
#contrasena:8813

select Persona_per_id from proveedor join persona on Persona_per_id=per_id where per_cedula=10007073 ;

call ConsultarProveedor(10002095,8130);
 

drop procedure if exists consultarCompras;
delimiter :o
create procedure consultarCompras(id int)
begin
	declare au int default -1;
	select per_id into au from cliente where per_id = id;
	if(au = -1) then
		select 'Cliente no existe';
	else
		select ven_fecha as fecha, nombre as bodega, per_name as vendedor, pro_name as producto, pro_precioVenta as precio, cantidad ,cantidad*pro_precioVenta as subtotal 
			from venta join bodega on Bodega_idBodega = idBodega join persona on Empleado_per_id = per_id join detalleVenta on ven_id = Venta_ven_id
			join product on idProducti = Product_idProducti where Cliente_per_id = id;
	end if;
end;
:o
delimiter ;

call consultarCompras(1);

select * from venta join bodega on Bodega_idBodega = idBodega join persona on Empleado_per_id = per_id join detalleVenta on ven_id = Venta_ven_id
	join product on idProducti = Product_idProducti;


drop procedure if exists ventas;
delimiter :*
create procedure ventas()
begin
	select * from ventasTotales;
end;
:*
delimiter ; 


call ventas();

