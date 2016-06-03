#................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
#................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................

#Transacciones

drop procedure if exists ActualizarCantidadBodegas;
delimiter $$
create procedure ActualizarCantidadBodegas(idPro int , idBod int, cant int)
begin
	
	start transaction;
	update product_has_bodega set cantidad=cant where  product_idProducti=idPro and Bodega_idBodega=idBod;
	
	if(cant<0)then
		rollback;
	end if;
	commit;
	
end;
$$
delimiter ;


#///////////////////////////////////

drop procedure if exists changePriceProduct;
delimiter $$
create procedure changePriceProduct( price int, namet varchar(30))
begin
		if(price<=0)then
			select 'Precio debe ser mayor a 0';
		else
			update product set pro_precioVenta=price where pro_name=namet;
			select 'Precio cambiado correctamente';
		end if;
end ;
$$
delimiter ;



call changePriceProduct(-2,'PTS');



#//////////////////////////////////////////


#EXISTEN DOS TRANSACCIONES MÁS EN EL SCRIPT DE CREACIÓN EN LOS PROCEDIMIENTOS buyProduct e insertarDetalleRemision.
