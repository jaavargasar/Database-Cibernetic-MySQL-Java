#The 10 who make more purshases
drop view if exists mostCurrent;
create view mostCurrent as select persona.per_name, count(ven_id) as purshases from cliente join venta on per_id=Cliente_per_id join persona using(per_id) group by per_id order by purshases desc limit 10; 
select * from mostCurrent;

#The sum of all sales
drop view if exists everythingSold;
create view everythingSold as select sum(cantidad*pro_precioVenta) from DetalleVenta join product on Product_idProducti= idProducti join venta on ven_id=Venta_ven_id;
select * from everythingSold;


#The average of the sales in march
select ven_id,avg(cantidad*pro_precioVenta) from DetalleVenta join product on Product_idProducti=idProducti join venta on Venta_ven_id=ven_id where ven_fecha>='2014-11-10' and ven_fecha <='2014-11-11' group by ven_id;


#Table of market number 3
drop view if exists market3;
create view market3 as select pro_name,cantidad_inicial,cantidad_agregada,(cantidad_inicial+cantidad_agregada) as total ,cantidad_final,  (cantidad_inicial+cantidad_agregada-cantidad_final) as sells , (cantidad_inicial+cantidad_agregada-cantidad_final)*pro_precioVenta as money from Product join MercadoHasProduct on Product_idProducti=idProducti join mercado on mercado.mer_id=MercadoHasProduct.Mercado_mer_id where mer_id = 3;
select * from market3;

#Total money of sold products for each market
drop view if exists totals;
create view totals as  select mer_id,fecha,sum((cantidad_inicial+cantidad_agregada-cantidad_final)*pro_precioVenta )as totalSell from Product join MercadoHasProduct on Product_idProducti= idProducti join mercado on mercado.mer_id=MercadoHasProduct.Mercado_mer_id group by mer_id;
select * from totals;

# Details of the refer made in 2014-11-11
select pro_name,det_cantidad , (det_cantidad*pro_precioVenta) from Remision join DetalleRemision on idRemision=Remision_idRemision join product on Product_idProducti=idProducti where rem_fecha = '2014-11-11';



#The greatest sell
drop view if exists greatestSell;
create view greatestSell as select per_name,ven_fecha,sum(cantidad*pro_precioVenta) as totalAmonunt from DetalleVenta join product on Product_idProducti=idProducti join venta on  Venta_ven_id=ven_id join cliente on per_id=Cliente_per_id join persona using(per_id)  group by ven_id order by totalAmonunt desc limit 1 ;
select * from greatestSell;



#The average of sell in markets
select avg(totalSell) from (select sum((cantidad_final+cantidad_agregada-cantidad_final)*pro_precioVenta )as totalSell from Product join MercadoHasProduct on Product_idProducti=idProducti join mercado  on  MercadoHasProduct.Mercado_mer_id=mer_id group by mercado.mer_id ) as amounts;





#The 3 most selled product
drop view if exists top3;
create view top3 as select pro_name,sum(cantidad) as number_of_selled , sum(cantidad)*pro_precioVenta from DetalleVenta join product on Product_idProducti=idProducti  group by idProducti order by number_of_selled desc limit 3 ;
select * from top3;


#the best seller in the best market																  #This inner part is the selection of the best market
select pro_name,( cantidad_inicial+cantidad_agregada - cantidad_final ) as aux from  MercadoHasProduct join totals on MercadoHasProduct.Mercado_mer_id=totals.mer_id join product on Product_idProducti=idProducti  order by aux desc limit 1;



#####################################################################
#Inventory of central warehouse
drop view if exists centralInventory;
create view centralInventory as select idProducti,pro_name,sum(det_cantidad) as aviable from bodega join remision on Bodega_idBodega=idBodega join DetalleRemision on Remision_idRemision= idRemision join product on Product_idProducti=idProducti where bodega.nombre = 'Central' group by idProducti;
select * from centralInventory;

#With the view the task became esier
#The minunum product in central warehouse (so do it more)
select * from centralInventory order by aviable limit 1;


#The maximun
select * from centralInventory order by aviable desc limit 1;


#What is the money that the warehouse has in products?
select sum(pro_precioVenta*aviable) as wareHouseMoney from centralInventory join product on centralInventory.idProducti=product.idProducti;

#####################################################################


#The totals of the warehouses
drop view if exists productsOnWareHouses;
create view productsOnWareHouses as select idBodega,nombre,sum(det_cantidad) as QuantityOfProducts from DetalleRemision join Remision on Remision_idRemision=idRemision  join bodega on Bodega_idBodega=idBodega group by idBodega ;
select * from productsOnWareHouses order by QuantityOfProducts;

#So the most fill warehouse is
select * from productsOnWareHouses order by QuantityOfProducts desc limit 1;

#The participation of the most-product owner respect to the total
select ( (select QuantityOfProducts from productsOnWareHouses order by QuantityOfProducts desc limit 1) / (select sum(QuantityOfProducts) from productsOnWareHouses));


#products in every warehouse (viewing it like a big warehosue)
drop view if exists universalWareHouse;
create view universalWareHouse as select idProducti,pro_name,sum(det_cantidad) as total from product join DetalleRemision on Product_idProducti=idProducti join remision on Remision_idRemision=idRemision group by idProducti ;
select * from universalWareHouse;



#####################################################################


select sum(subTotal) as EveryMoneyCompanyHasSold from (select (pro_precioVenta*total ) as subTotal from universalWareHouse join product on Product.idProducti=universalWareHouse.idProducti ) as aux ;

#Mean and std desviaion of the distributions of the products in warehouses
drop view if exists stadistics;
create view stadistics as select avg(QuantityOfProducts) as mean ,STDDEV_SAMP(QuantityOfProducts) as stddesv from productsOnWareHouses;
select * from stadistics;


#Clients who have bought more than 1.000.000
drop view if exists goodClients;
create view goodClients as select per_cedula,per_name,sum(pro_precioVenta*cantidad) as bought from cliente join venta  on Cliente_per_id= per_id join DetalleVenta on Venta_ven_id=ven_id join product on Product_idProducti=idProducti join persona using(per_id) group by per_id having sum(pro_precioVenta*cantidad)>1000000 order by bought desc;
select * from goodClients;


#####################################################################

#Products sell the 1st an 2nd os june
select idProducti,pro_name from product where idProducti in (select distinct idProducti from  venta  join DetalleVenta on Venta_ven_id=ven_id join product on Product_idProducti=idProducti where ven_fecha >= '2014-11-10' and ven_fecha<='2014-11-11'); 


#Clients who bought in twelve june
select per_id,per_name,per_direccion from cliente join persona using(per_id) join venta on Cliente_per_id=per_id where per_id in (select per_id from cliente join venta on Cliente_per_id= per_id )  and ven_fecha='2014,11,11';



#The best client for product 1
select per_id,per_name,sum(cantidad ) from cliente  join venta on  Cliente_per_id=per_id join DetalleVenta on Venta_ven_id=ven_id join product on Product_idProducti=idProducti join persona using(per_id ) where idProducti = 1 group by per_id order by cantidad desc limit 1;



#References whose has less than 1000 products sended
drop view if exists smallRefer;
create view smallRefer as select idRemision,rem_fecha,Bodega_idBodega,sum(det_cantidad) as totalQ from remision join DetalleRemision on Remision_idRemision=idRemision group by idRemision  having sum(det_cantidad) < 1000;
select * from smallRefer order by totalQ desc ;

#####################################################################



#References whose has at least 30 products sended
drop view if exists bigRefer;
create view bigRefer as select idRemision,rem_fecha,Bodega_idBodega,sum(det_cantidad) as totalQ from remision join DetalleRemision on Remision_idRemision=idRemision group by idRemision  having sum(det_cantidad) >= 30;
select * from bigRefer order by totalQ desc ;











#The price of fabrication for each product
drop view if exists price_of_fabrication;
create view price_of_fabrication as select idProducti, pro_name, sum(costoInsumos+costoRollo) as price_of_fabrication from detallesFabricacion join product on  Product_idProducti=idProducti join detallesFabricacion_has_insumos on detallesFabricacion_iddetallesFabricacion=iddetallesFabricacion  group by idProducti order by costoInsumos desc ;
select * from price_of_fabrication;


#The most used supplies
drop view if exists most_used_sp;
create view most_used_sp as select ins_nombre, count(idProducti) as most_used_sp from detallesFabricacion join product on Product_idProducti=idProducti join detallesFabricacion_has_insumos on detallesFabricacion_iddetallesFabricacion=iddetallesFabricacion join insumos  on idinsumos=insumos_idinsumos   group by idinsumos order by most_used_sp desc ;
select * from most_used_sp;


drop view if exists proveedores;
create view proveedores as select * from proveedor join persona on Persona_per_id = per_id;
select * from proveedores;


drop view if exists rollosPedidos;
create view rollosPedidos as select * from provee join rollo on idRollo = Rollo_idRollo;
select * from rollosPedidos;


drop view if exists ventasTotales;
create view ventasTotales as select sum(cantidad*pro_precioVenta) from detalleventa join product on Product_idProducti = idProducti










