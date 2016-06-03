#select Empleado_per_id,sum(cantidad*pro_precioVenta) from venta join detalleventa on ven_id = Venta_ven_id join product on Product_idProducti = idProducti group by Empleado_per_id;
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
#/////////////////////////////

drop procedure if exists VentaEmpleados;
delimiter :I
create procedure VentaEmpleados ()
begin
	declare sum,Empid int default -1;
	declare done int default 0;
	declare cursorSumEmp cursor for select Empleado_per_id ,sum(cantidad*pro_precioVenta) from venta join detalleventa on ven_id = Venta_ven_id 
										join product on Product_idProducti = idProducti group by Empleado_per_id;

	declare continue handler for sqlstate '02000' set done = 1;
	
	open cursorSumEmp;
	repeat	
		fetch cursorSumEmp into Empid,sum;
		if( not done ) then
			select Empid,sum;
		end if;
	until done end repeat;
	close cursorSumEmp;
end;
:I
delimiter ;

call VentaEmpleados();

#//////////////////////////////////

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











