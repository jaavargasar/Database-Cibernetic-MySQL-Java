#drop database cibernetic4;
create database cibernetic4;
use Cibernetic4;

#drop database cibernetic;

-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Product (
  `idProducti` INT NOT NULL AUTO_INCREMENT,
  `pro_name` VARCHAR(45) NULL,
  `pro_ref` VARCHAR(45) NULL,
  `pro_talla` varchar(45) NULL, 
  `pro_precioVenta` INT NULL,
  PRIMARY KEY (`idProducti`));



-- -----------------------------------------------------
-- Table `mydb`.`Bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Bodega (
  `idBodega` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` INT NULL,
  PRIMARY KEY (`idBodega`));

#select * from bodega;

-- -----------------------------------------------------
-- Table `mydb`.`Product_has_Bodega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Product_has_Bodega(
	idRegis int not null primary key auto_increment,
  `Product_idProducti` INT NOT NULL,
  `Bodega_idBodega` INT NOT NULL,
  `cantidad` INT NULL,
  #PRIMARY KEY (`Product_idProducti`, `Bodega_idBodega`),
  INDEX `IndPHB_idBodega` (`Bodega_idBodega` ASC),
  INDEX `IndPHB_idProducti` (`Product_idProducti` ASC),
    FOREIGN KEY (`Product_idProducti`) REFERENCES `Product` (`idProducti`),
    FOREIGN KEY (`Bodega_idBodega`) REFERENCES `Bodega` (`idBodega`)
);


#select * from bodega;


-- -----------------------------------------------------
-- Table `mydb`.`Remision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Remision (
  `idRemision` INT NOT NULL auto_increment,
  `rem_fecha` DATE NULL,
  `Bodega_recibe` INT NOT NULL,
  `Bodega_idBodega` INT NOT NULL,
  #PRIMARY KEY (`idRemision`, `Bodega_recibe`, `Bodega_idBodega`),
  PRIMARY KEY (`idRemision`),
  INDEX `IndRec_recibe` (`Bodega_recibe` ASC),
  INDEX `IndRec_idBodega` (`Bodega_idBodega` ASC),
    FOREIGN KEY (`Bodega_recibe`) REFERENCES `Bodega` (`idBodega`),
    FOREIGN KEY (`Bodega_idBodega`) REFERENCES `Bodega` (`idBodega`)
);


-- -----------------------------------------------------
-- Table `mydb`.`DetalleRemision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DetalleRemision (
  `idDetalleRemision` INT NOT NULL auto_increment,
  `det_cantidad` INT NULL,
  `det_precio` INT NULL,
  `Product_idProducti` INT NOT NULL,
  `Remision_idRemision` INT NOT NULL,
  #PRIMARY KEY (`idDetalleRemision`, `Product_idProducti`, `Remision_idRemision`),
  PRIMARY KEY (`idDetalleRemision`),
  INDEX `IndDet_idProducti` (`Product_idProducti` ASC),
  INDEX `IndDet_idRemision` (`Remision_idRemision` ASC),
    FOREIGN KEY (`Product_idProducti`) REFERENCES `Product` (`idProducti`),
  FOREIGN KEY (`Remision_idRemision`) REFERENCES `Remision` (`idRemision`)
);


-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS Persona (
  `per_id` INT NOT NULL AUTO_INCREMENT,
  `per_cedula` INT NOT NULL,
	contrasena varchar(35) not null,
  `per_direccion` VARCHAR(45) NULL,
  `per_telefono` INT NULL,
  `per_name` VARCHAR(45) NULL,
  `per_antiguedad` DATE NULL,
  PRIMARY KEY (`per_id`, `per_cedula` ));


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  `puntos` INT NULL,
  `per_id` INT NOT NULL,
  PRIMARY KEY (`per_id`),
    FOREIGN KEY (`per_id`) REFERENCES `Persona` (`per_id`)
);


#select per_id from cliente join persona using (per_id) where per_cedula=;

-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Empleado (
  `salario` INT NULL,
  `per_id` INT NOT NULL,
  PRIMARY KEY (`per_id`),
    FOREIGN KEY (`per_id`)
    REFERENCES `Persona` (`per_id`)
);


-- -----------------------------------------------------
-- Table `mydb`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Venta (
  `ven_id` INT NOT NULL AUTO_INCREMENT,
  `ven_fecha` DATE NULL,
  `Cliente_per_id` INT NOT NULL,
  `Empleado_per_id` INT NOT NULL,
  `Bodega_idBodega` INT NOT NULL,
  #PRIMARY KEY (`ven_id`, `Cliente_per_id`, `Empleado_per_id`, `Bodega_idBodega`),
PRIMARY KEY (`ven_id`),
  INDEX `IndVen_Cliente` (`Cliente_per_id` ASC),
  INDEX `IndVen_Empleado` (`Empleado_per_id` ASC),
  INDEX `IndVen_idBodega` (`Bodega_idBodega` ASC),
    FOREIGN KEY (`Cliente_per_id`)
    REFERENCES `Cliente` (`per_id`),
    FOREIGN KEY (`Empleado_per_id`)
    REFERENCES `Empleado` (`per_id`),
    FOREIGN KEY (`Bodega_idBodega`)
    REFERENCES `Bodega` (`idBodega`)
);


-- -----------------------------------------------------
-- Table `mydb`.`DetalleVenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DetalleVenta (
  `dven_id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL,
  `Venta_ven_id` INT NOT NULL,
  `Product_idProducti` INT NOT NULL,
 # PRIMARY KEY (`dven_id`, `Venta_ven_id`, `Product_idProducti`),
PRIMARY KEY (`dven_id`),
  INDEX `IndDetV_venid` (`Venta_ven_id` ASC),
  INDEX `IndDetV_idProducti` (`Product_idProducti` ASC),
    FOREIGN KEY (`Venta_ven_id`)
    REFERENCES `Venta` (`ven_id`),
    FOREIGN KEY (`Product_idProducti`)
    REFERENCES `Product` (`idProducti`)
);


-- -----------------------------------------------------
-- Table `mydb`.`Mercado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Mercado(
  `fecha` DATE NULL,
  `mer_id` INT NOT NULL AUTO_INCREMENT,
  `Mercado_mer_id` INT,
  #PRIMARY KEY (`mer_id`, `Mercado_mer_id`),
PRIMARY KEY (`mer_id`),
  INDEX `IndMer_merid` (`Mercado_mer_id` ASC),
    FOREIGN KEY (`Mercado_mer_id`)
    REFERENCES `Mercado` (`mer_id`)
);

#drop table mercado;
-- -----------------------------------------------------
-- Table `mydb`.`MercadoHasProduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MercadoHasProduct(
  `idMercadoHasProduct` INT NOT NULL AUTO_INCREMENT,
  `cantidad_inicial` INT NULL,
  `cantidad_final` INT NULL,
  `cantidad_agregada` INT NULL,
  `Mercado_mer_id` INT NOT NULL,
  `Product_idProducti` INT NOT NULL,
  #PRIMARY KEY (`idMercadoHasProduct`, `Mercado_mer_id`, `Product_idProducti`),
PRIMARY KEY (`idMercadoHasProduct`),
  INDEX `IndMerc_merid` (`Mercado_mer_id` ASC),
  INDEX `IndMerc_idProducti` (`Product_idProducti` ASC),
    FOREIGN KEY (`Mercado_mer_id`)
    REFERENCES `Mercado` (`mer_id`),
    FOREIGN KEY (`Product_idProducti`)
    REFERENCES `Product` (`idProducti`)
);


-- -----------------------------------------------------
-- Table `mydb`.`Fabricacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fabricacion (
  `idFabricacion` INT NOT NULL AUTO_INCREMENT,
  `fab_fecha` DATE NULL,
  `Bodega_idBodega` INT NOT NULL,
 # PRIMARY KEY (`idFabricacion`, `Bodega_idBodega`),
PRIMARY KEY (`idFabricacion`),
  INDEX `IndFab	_idBodega` (`Bodega_idBodega` ASC),
    FOREIGN KEY (`Bodega_idBodega`)
    REFERENCES `Bodega` (`idBodega`)
);


-- -----------------------------------------------------
-- Table `mydb`.`Rollo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Rollo(
  `idRollo` INT NOT NULL AUTO_INCREMENT,
  `rol_referencia` VARCHAR(45) NULL,
  `rol_peso` INT NULL,
  `rol_longitud` INT NULL,
  `rol_color` VARCHAR(45) NULL,
  `rol_precioKilogramo` INT NULL,
  PRIMARY KEY (`idRollo`));



-- -----------------------------------------------------
-- Table `mydb`.`detallesFabricacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS detallesFabricacion(
  `iddetallesFabricacion` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL,
  `costoInsumos` INT NULL,
  `Fabricacion_idFabricacion` INT NOT NULL,
  `Product_idProducti` INT NOT NULL,
  `Rollo_idRollo` INT NOT NULL,
  `costoRollo` INT NULL,
  #PRIMARY KEY (`iddetallesFabricacion`, `Fabricacion_idFabricacion`, `Product_idProducti`, `Rollo_idRollo`),
PRIMARY KEY (`iddetallesFabricacion`),
  INDEX `IndetaF_idFabricacion` (`Fabricacion_idFabricacion` ASC),
  INDEX `IndetaF_idProducti` (`Product_idProducti` ASC),
  INDEX `IndetaF_idRollo` (`Rollo_idRollo` ASC),
    FOREIGN KEY (`Fabricacion_idFabricacion`)
    REFERENCES `Fabricacion` (`idFabricacion`),
    FOREIGN KEY (`Product_idProducti`)
    REFERENCES `Product` (`idProducti`),
    FOREIGN KEY (`Rollo_idRollo`)
    REFERENCES `Rollo` (`idRollo`)
);


-- -----------------------------------------------------
-- Table `mydb`.`insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS insumos(
  `idinsumos` INT NOT NULL AUTO_INCREMENT,
  `ins_nombre` VARCHAR(45) NULL,
  `ins_precio` INT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`idinsumos`));



-- -----------------------------------------------------
-- Table `mydb`.`detallesFabricacion_has_insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS detallesFabricacion_has_insumos(
  idRegistro int not null auto_increment primary key,
  `detallesFabricacion_iddetallesFabricacion` INT NULL,
  `insumos_idinsumos` INT NULL,
  `costoInsumo` INT NULL,
  `cantidadUsada` INT NULL,
  #PRIMARY KEY (`detallesFabricacion_iddetallesFabricacion`, `insumos_idinsumos`),
  INDEX `IndDHI_idinsumos` (`insumos_idinsumos` ASC),
  INDEX `IndDHI_iddetaller` (`detallesFabricacion_iddetallesFabricacion` ASC),
    FOREIGN KEY (`detallesFabricacion_iddetallesFabricacion`)
    REFERENCES `detallesFabricacion` (`iddetallesFabricacion`),
    FOREIGN KEY (`insumos_idinsumos`)
    REFERENCES `insumos` (`idinsumos`)
);


-- -----------------------------------------------------
-- Table `mydb`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Proveedor(
  `Persona_per_id` INT NOT NULL,
  `nit` INT NULL,
  PRIMARY KEY (`Persona_per_id`),
    FOREIGN KEY (`Persona_per_id`)
    REFERENCES `Persona` (`per_id`)
);



-- -----------------------------------------------------
-- Table `mydb`.`Provee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Provee(
	idRegistroProvee int not null primary key auto_increment,
  `Rollo_idRollo` INT NOT NULL,
  `Proveedor_Persona_per_id` INT NOT NULL,
  INDEX `IndPro_personaid` (`Proveedor_Persona_per_id` ASC),
  INDEX `IndPro_idRollo` (`Rollo_idRollo` ASC),
    FOREIGN KEY (`Rollo_idRollo`)
    REFERENCES `Rollo` (`idRollo`),
    FOREIGN KEY (`Proveedor_Persona_per_id`)
    REFERENCES `Proveedor` (`Persona_per_id`)
);


-- -----------------------------------------------------
-- Table `mydb`.`proveeInsumo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS proveeInsumo(
	idregistroProveeInsumo int not null auto_increment primary key,
  `insumos_idinsumos` INT NOT NULL,
  `Proveedor_Persona_per_id` INT NOT NULL,
  `cantidad` INT NULL,
  INDEX `IndPI_personaid` (`Proveedor_Persona_per_id` ASC),
  INDEX `IndPI_idinsumos` (`insumos_idinsumos` ASC),
    FOREIGN KEY (`insumos_idinsumos`)
    REFERENCES `insumos` (`idinsumos`),
    FOREIGN KEY (`Proveedor_Persona_per_id`)
    REFERENCES `Proveedor` (`Persona_per_id`)
);


#################################################
#indices
#Bodega
create  index  ind_nombreBodega on Bodega(nombre) ;
#remisiones
create  index  ind_fechaRemisiones on Remision(rem_fecha) ;
#persona
create  index  ind_nombrePersona on Persona(per_name) ;
create UNIQUE index ind_cedulaPersona  using  BTREE  on persona (per_cedula);
#ventas
create  index  ind_fechaVentas on venta(ven_fecha) ;
#insumos
create  index  ind_nombreInsumos on insumos(ins_nombre) ;

drop procedure if exists insertProduct;
delimiter $$
create procedure insertProduct(nombre varchar(45) , referencia varchar(45) , talla varchar(10), precio int)
	begin
		insert into product (pro_name,pro_ref,pro_talla,pro_precioVenta) values (nombre,referencia,talla,precio);
	end;
$$
delimiter ;


call insertProduct ('PTS','PTS','S',10000);
call insertProduct ('PTM','PTM','M',10000);
call insertProduct ('PTL','PTL','L',10000);
call insertProduct ('PTXL','PTXL','XL',10000);
call insertProduct ('C3LSm','C3LSm','S',15000);
call insertProduct ('C3LMm','C3LMm','M',15000);
call insertProduct ('C3LLm','C3LLm','L',15000);
call insertProduct ('C3LXLm','C3LXLm','XL',17000);
call insertProduct ('PTM1','PTM1','M',7500);
call insertProduct ('PTL1','PTL1','L',7500);
call insertProduct ('CN4','CN4','4',7500);
call insertProduct ('CN6','CN6','6',7500);
call insertProduct ('CN8','CN8','8',7500);
call insertProduct ('CN10','CN10','10',10000);
call insertProduct ('CN12','CN12','12',10000);
call insertProduct ('CN14','CN14','14',10000);
call insertProduct ('CN16','CN16','16',10000);
call insertProduct ('CPQS','CPQS','S',10000);
call insertProduct ('CPQM','CPQM','M',10000);
call insertProduct ('CPQL','CPQL','L',10000);
call insertProduct ('CPQXL','CPQXL','XL',12000);
call insertProduct ('PQ2LS','PQ2LS','S',6000);
call insertProduct ('PQ2LM','PQ2LM','M',6000);
call insertProduct ('PQ2LL','PQ2LL','L',6000);
call insertProduct ('LEGUISS','LEGUISS','S',6000);
call insertProduct ('LEGUISM','LEGUISM','M',6000);
call insertProduct ('LEGUISL','LEGUISL','L',6000);
call insertProduct ('LEGUISXL','LEGUISXL','XL',7000);
call insertProduct ('CCHS','CCHS','S',18000);
call insertProduct ('CCHM','CCHM','M',18000);
call insertProduct ('CCHL','CCHL','L',18000);
call insertProduct ('CCHXL','CCHXL','XL',20000);
call insertProduct ('CCH4','CCH4','4',11000);
call insertProduct ('CCH6','CCH6','6',11000);
call insertProduct ('CCH8','CCH8','8',11000);
call insertProduct ('CCH10','CCH10','10',14000);
call insertProduct ('CCH12','CCH12','12',14000);
call insertProduct ('CCH14','CCH14','14',14000);
call insertProduct ('CCH16','CCH16','16',14000);
call insertProduct ('B2L','B2L','L',3000);
call insertProduct ('LEGUIS 4','LEGUIS 4','4',4000);
call insertProduct ('LEGUIS 6','LEGUIS 6','6',4000);
call insertProduct ('LEGUIS 8','LEGUIS 8','8',4000);
call insertProduct ('LEGUIS 10','LEGUIS 10','10',5000);
call insertProduct ('LEGUIS 12','LEGUIS 12','12',5000);
call insertProduct ('LEGUIS 14','LEGUIS 14','14',5000);
call insertProduct ('LEGUIS 16','LEGUIS 16','16',5000);
call insertProduct ('CFS','CFS','S',11000);
call insertProduct ('CFM','CFM','M',11000);
call insertProduct ('CFL','CFL','L',11000);
call insertProduct ('LEGUISS3L','LEGUISS3L','S',7000);
call insertProduct ('LEGUISM3L','LEGUISM3L','M',7000);
call insertProduct ('LEGUISL3L','LEGUISL3L','L',7000);
call insertProduct ('LEGUISXL3L','LEGUISXL3L','XL',8000);
call insertProduct ('PQ2L XL','PQ2L XL','XL',7000);
call insertProduct ('PQ2L XXL','PQ2L XXL','XXL',7000);
call insertProduct ('C3L LEG S','C3L LEG S','S',12000);
call insertProduct ('C3L LEG M','C3L LEG M','M',12000);
call insertProduct ('C3L LEG L','C3L LEG L','L',12000);
call insertProduct ('C3L LEG XL','C3L LEG XL','XL',16000);
call insertProduct ('C3L LG CH S','C3L LG CH S','S',17000);
call insertProduct ('C3L LG CH M','C3L LG CH M','M',17000);
call insertProduct ('C3L LG CH L','C3L LG CH L','L',17000);
call insertProduct ('C3L LG CH XL','C3L LG CH XL','XL',18000);
call insertProduct ('BSL 10','BSL 10','10',2500);
call insertProduct ('BSL 16','BSL 16','16',2500);
call insertProduct ('LEG MT S','LEG MT S','S',7000);
call insertProduct ('LEG MT M','LEG MT M','M',7000);
call insertProduct ('LEG MT U','LEG MT U','unica',8000);
call insertProduct ('LEG ET','LEG ET','unica',8000);

#select * from product;

drop procedure if exists insertarBodega;
delimiter $$
create procedure insertBodega(nombre varchar(45) , direccion varchar(45) , telefono int )
	begin
		insert into Bodega (nombre,direccion,telefono) values (nombre,direccion,telefono);
	end;
$$
delimiter ;

drop trigger if exists c_inventario;
delimiter $$
create trigger c_inventario after insert on bodega
		for each row begin
		set @id = NEW.idBodega;
		set @productos = 0; select count(*) into @productos from product; 
		set @counter = 1;
		while @counter <= @productos DO
			insert into product_has_bodega (Product_idProducti,Bodega_idBodega,cantidad)  values (@counter,@id,0);
			set @counter = @counter +1 ;
		end while;
	end
$$
delimiter ;

#select * from product_has_bodega;



call insertBodega('Central','Carrera # 44Q sur',7776540);
call insertBodega('Central 2','Carrera # 44Q sur',7776540);
call insertBodega('Distribuidora','Carrera # 186V sur',2323412);
call insertBodega('Occidente','Trasversal # 48Q sur',2312345);
call insertBodega('Proveedora','Calle # 101V este',1324467);
call insertBodega('Norte','Calle # 70H este',8542124);
call insertBodega('Este','Calle # 85D norte',4434567);
call insertBodega('Sur','Trasversal # 169N norte',1237654);
call insertBodega('Recursos','Carrera # 73E sur',9897678);
call insertBodega('Utensilios','Calle # 132W oeste',4534565);
call insertBodega('Insumos','Calle # 192U este',6567656);
call insertBodega('Produccion','Carrera # 44H norte',3454567);
call insertBodega('Manofactura','Carrera # 63J sur',5456787);
call insertBodega('SubCetral','Calle # 47L norte',9898764);
call insertBodega('Fabricacion','Calle # 174B norte',7765678);
call insertBodega('Diseño','Carrera # 158Y norte',7656787);

#select * from Bodega;


drop procedure if exists insertarPersona;
delimiter %%
create procedure insertarPersona(nombre varchar(45) , cedula int ,direccion varchar(45) , telefono int, contrasena varchar(30))
	begin
		insert into persona (per_name,per_direccion,per_telefono,per_cedula,per_antiguedad,contrasena) values (nombre,direccion,telefono,cedula,curdate(),contrasena);
	end;
%%
delimiter ;

#select * from persona;

call insertarPersona('Andres Mauricio Rondon',1012429484,'Calle 58 i bis # 79 b 18',7776470,'8859');
call insertarPersona('Abi',10002407,'Calle # 121E oeste',7004239,'15445');
call insertarPersona('Abigail',10001924,'Carrera # 86E sur',7010672,'14146');
call insertarPersona('Abril',10002595,'Calle # 107N norte',7030506,'12700');
call insertarPersona('Acnina',10009180,'Calle # 112X norte',7012457,'30425');
call insertarPersona('Ada',10007858,'Calle # 35S norte',7027888,'26931');
call insertarPersona('Adaia',10009451,'Trasversal # 174L oeste',7019896,'28455');
call insertarPersona('Ade',10008856,'Carrera # 35Y este',7024155,'7346');
call insertarPersona('Adela',10009716,'Carrera # 126C oeste',7029764,'4746');
call insertarPersona('Adelaida',10003981,'Trasversal # 15X oeste',7012637,'16263');
call insertarPersona('Adelfa',10008740,'Calle # 155J este',7010230,'12088');
call insertarPersona('Adelia',10008120,'Trasversal # 103R sur',7023759,'21918');
call insertarPersona('Adelina',10001501,'Trasversal # 71C sur',7020304,'13743');
call insertarPersona('Adelma',10007567,'Carrera # 93L oeste',7006425,'16544');
call insertarPersona('Adhara',10006021,'Carrera # 74N oeste',7028014,'28564');
call insertarPersona('Adolfina',10006429,'Calle # 62T oeste',7005667,'16334');
call insertarPersona('Adoración',10003198,'Carrera # 81W norte',7020250,'4750');
call insertarPersona('Adria',10007989,'Trasversal # 166A norte',7025211,'32764');
call insertarPersona('Adriana',10007623,'Trasversal # 180E oeste',7030486,'14039');
call insertarPersona('Afrodita',10002520,'Carrera # 78Y norte',7028614,'17478');
call insertarPersona('Agar',10009971,'Calle # 199S sur',7021925,'14247');
call insertarPersona('Agata',10009298,'Carrera # 9A sur',7024683,'13672');
call insertarPersona('Agnece',10002617,'Trasversal # 127X este',7005979,'29604');
call insertarPersona('Agostina',10000042,'Trasversal # 152L norte',7002686,'5351');
call insertarPersona('Agueda',10001564,'Trasversal # 93R sur',7005925,'21995');
call insertarPersona('Agustina',10003641,'Calle # 139S norte',7023530,'14953');
call insertarPersona('Aida',10009548,'Carrera # 192G oeste',7016283,'5249');
call insertarPersona('Aiena',10009418,'Calle # 141A este',7003042,'13553');
call insertarPersona('Aikea',10003853,'Carrera # 129R norte',7026500,'14121');
call insertarPersona('Ailen',10000483,'Trasversal # 190N norte',7017800,'30427');
call insertarPersona('Ailin',10001734,'Calle # 34G oeste',7030122,'20968');
call insertarPersona('Ailsa',10005491,'Calle # 145P sur',7014303,'27335');
call insertarPersona('Aime',10001726,'Carrera # 33R este',7022495,'30921');
call insertarPersona('Aimir',10000990,'Carrera # 98C norte',7014062,'216');
call insertarPersona('Ain',10009426,'Trasversal # 51I norte',7006479,'24218');
call insertarPersona('Ainara',10000341,'Carrera # 61P sur',7023093,'32498');
call insertarPersona('Ainhoa',10000521,'Trasversal # 129T norte',7009224,'24252');
call insertarPersona('Aira',10000969,'Calle # 57O norte',7017492,'29659');
call insertarPersona('Aisha',10004988,'Carrera # 81Y norte',7031174,'29239');
call insertarPersona('Aitana',10006354,'Carrera # 141F este',7032761,'27753');
call insertarPersona('Aixa',10003265,'Trasversal # 135F sur',7028675,'21171');
call insertarPersona('Akemi',10009611,'Calle # 32L sur',7007689,'17189');
call insertarPersona('Akie',10007096,'Carrera # 97Q sur',7015166,'25100');
call insertarPersona('Alaide',10001697,'Carrera # 82Q sur',7000274,'26127');
call insertarPersona('Alana',10006903,'Carrera # 147Q sur',7021899,'25487');
call insertarPersona('Alaina',10001692,'Carrera # 66E norte',7000497,'2912');
call insertarPersona('Alanis',10006874,'Carrera # 98V sur',7003163,'15404');
call insertarPersona('Alba',10009885,'Carrera # 133F oeste',7022975,'21886');
call insertarPersona('Albana',10002197,'Trasversal # 4H oeste',7016780,'22809');
call insertarPersona('Albertina',10001736,'Trasversal # 168X este',7032000,'10115');
call insertarPersona('Albida',10000908,'Carrera # 138C este',7011187,'6338');
call insertarPersona('Albina',10007908,'Carrera # 150N oeste',7021518,'14083');
call insertarPersona('Alcira',10008150,'Trasversal # 17C oeste',7008616,'12276');
call insertarPersona('Alda',10003345,'Calle # 135S este',7031938,'3317');
call insertarPersona('Aldana',10008349,'Trasversal # 139T norte',7015698,'5541');
call insertarPersona('Ale',10008458,'Carrera # 29N norte',7000356,'30441');
call insertarPersona('Alegori',10009018,'Calle # 63D oeste',7025013,'4560');
call insertarPersona('Aleida',10008156,'Calle # 8V sur',7012500,'13045');
call insertarPersona('Alejandra',10005951,'Carrera # 102I este',7028728,'12333');
call insertarPersona('Alejandrina',10004549,'Trasversal # 140M oeste',7001018,'13307');
call insertarPersona('Alenka',10008004,'Calle # 91K sur',7014651,'7647');
call insertarPersona('Alessandra',10006752,'Carrera # 60E sur',7015466,'2361');
call insertarPersona('Alessia',10005062,'Carrera # 65J norte',7029656,'28998');
call insertarPersona('Alexandra',10009937,'Carrera # 83T sur',7010331,'2884');
call insertarPersona('Alexia',10007998,'Calle # 152R oeste',7018680,'5517');
call insertarPersona('Alfonsa',10006893,'Trasversal # 161W sur',7014282,'16853');
call insertarPersona('Alfonsina',10002094,'Calle # 51O norte',7015769,'8130');
call insertarPersona('Alicia',10005323,'Calle # 78L este',7020201,'20761');
call insertarPersona('Alihuen',10005777,'Carrera # 61E oeste',7002142,'16748');
call insertarPersona('Aliki',10007073,'Calle # 145N este',7000461,'29279');
call insertarPersona('Alin',10000932,'Trasversal # 199F este',7007767,'27892');
call insertarPersona('Alondra',10006344,'Calle # 97M oeste',7009559,'23386');
call insertarPersona('Aluen',10008623,'Trasversal # 179R este',7000786,'8813');
call insertarPersona('Aluhe',10001874,'Carrera # 136K este',7024931,'20561');
call insertarPersona('Alumine',10001593,'Calle # 20I sur',7010209,'20346');
call insertarPersona('Alvina',10004126,'Trasversal # 172M norte',7012335,'16628');
call insertarPersona('Amada',10005644,'Calle # 1B norte',7026221,'17238');
call insertarPersona('Amaia',10008633,'Calle # 36F este',7030477,'3246');
call insertarPersona('Amaike',10001909,'Trasversal # 125Q oeste',7025211,'90');
call insertarPersona('Amalia',10007000,'Carrera # 87K oeste',7009292,'12970');
call insertarPersona('Amancay',10007038,'Carrera # 120M oeste',7024316,'15984');
call insertarPersona('Amanda',10003299,'Trasversal # 5T este',7032355,'4841');
call insertarPersona('Amandla',10007759,'Calle # 22K oeste',7021083,'20049');
call insertarPersona('Amara',10002020,'Trasversal # 28A este',7004191,'20758');
call insertarPersona('Amaranta',10009155,'Carrera # 163X norte',7017922,'19328');
call insertarPersona('Amaray',10001905,'Trasversal # 127P norte',7024462,'12034');
call insertarPersona('Amarena',10005720,'Carrera # 144N oeste',7019757,'15207');
call insertarPersona('Amarilis',10005494,'Calle # 58K este',7022123,'9194');
call insertarPersona('Amaru',10006410,'Carrera # 76V norte',7007923,'27129');
call insertarPersona('Amatista',10009079,'Carrera # 12M sur',7004300,'24306');
call insertarPersona('Ambar',10009791,'Calle # 74I sur',7008081,'6343');
call insertarPersona('Ambay',10004836,'Calle # 87A sur',7030027,'5756');
call insertarPersona('Ambrosia',10000070,'Calle # 27O norte',7025849,'31600');
call insertarPersona('Amelia',10009406,'Carrera # 4K sur',7018417,'21321');
call insertarPersona('Amelie',10009468,'Carrera # 70J norte',7000666,'5326');
call insertarPersona('America',10006218,'Carrera # 82B norte',7008745,'7554');
call insertarPersona('Amina',10008368,'Trasversal # 55I este',7010352,'25168');
call insertarPersona('Amira',10005204,'Trasversal # 184X este',7031715,'25366');
call insertarPersona('Amneris',10000824,'Trasversal # 47Q oeste',7024911,'28514');
call insertarPersona('Amor',10007382,'Calle # 27Y norte',7012806,'27161');
call insertarPersona('Amorina',10004099,'Calle # 109F sur',7031852,'30927');


#select * from persona;


drop procedure if exists insertarRollo;
delimiter $$
create procedure insertarRollo( referencia varchar(45), peso int , longitud int ,color varchar(45), kg int)
	begin
		insert into Rollo (rol_referencia,rol_peso,rol_longitud,rol_color,rol_precioKilogramo) values(referencia,peso,longitud,color,kg);
	end ;
$$
delimiter ;


call insertarRollo('fina',40,226,'morado',2202);
call insertarRollo('regular',40,321,'blanco',3064);
call insertarRollo('arrugado',30,296,'cafe',2513);
call insertarRollo('liso',19,249,'rojo',2226);
call insertarRollo('ancho',15,216,'verde',3980);
call insertarRollo('fina',33,277,'verde',2880);
call insertarRollo('ancho',25,261,'morado',2499);
call insertarRollo('arrugado',31,309,'cafe',3294);
call insertarRollo('sedoso',43,330,'amarillo',3777);
call insertarRollo('liso',41,232,'verde',2456);
call insertarRollo('fina',45,335,'cafe',3604);
call insertarRollo('ancho',41,240,'azul',2906);
call insertarRollo('ancho',16,292,'rojo',2876);
call insertarRollo('fina',33,237,'azul',3854);
call insertarRollo('regular',21,265,'amarillo',3708);
call insertarRollo('ancho',38,329,'verde',3043);
call insertarRollo('fina',33,299,'blanco',3278);
call insertarRollo('regular',28,230,'negro',2850);
call insertarRollo('liso',25,302,'naraja',3131);
call insertarRollo('sedoso',36,208,'verde',3383);
call insertarRollo('fina',43,219,'naraja',2465);
call insertarRollo('fina',44,209,'blanco',2745);
call insertarRollo('liso',33,311,'cafe',2475);
call insertarRollo('sedoso',19,264,'cafe',2520);
call insertarRollo('fina',32,238,'blanco',3518);
call insertarRollo('arrugado',18,264,'amarillo',3561);
call insertarRollo('arrugado',35,270,'rojo',3703);
call insertarRollo('arrugado',32,325,'naraja',2388);
call insertarRollo('sedoso',24,315,'blanco',3049);
call insertarRollo('sedoso',37,240,'naraja',2689);
call insertarRollo('sedoso',27,314,'amarillo',2552);
call insertarRollo('ancho',32,335,'rojo',3803);
call insertarRollo('fina',34,314,'negro',3156);
call insertarRollo('regular',18,216,'cafe',2556);
call insertarRollo('ancho',25,238,'naraja',2765);
call insertarRollo('regular',33,296,'cafe',3520);
call insertarRollo('regular',16,200,'negro',2655);
call insertarRollo('ancho',32,215,'negro',3735);
call insertarRollo('sedoso',36,302,'verde',2404);
call insertarRollo('arrugado',36,227,'blanco',2333);
call insertarRollo('fina',31,278,'azul',2986);
call insertarRollo('popular',36,330,'verde',2488);
call insertarRollo('sedoso',45,224,'blanco',2542);
call insertarRollo('sedoso',17,285,'rojo',3997);
call insertarRollo('liso',23,321,'rojo',3877);
call insertarRollo('fina',34,227,'blanco',3585);
call insertarRollo('regular',34,281,'verde',3013);
call insertarRollo('arrugado',32,298,'morado',3692);
call insertarRollo('liso',43,275,'amarillo',2531);
call insertarRollo('arrugado',33,294,'morado',2540);
call insertarRollo('fina',33,300,'rojo',3090);
call insertarRollo('popular',32,220,'cafe',3444);
call insertarRollo('fina',16,298,'morado',3841);
call insertarRollo('liso',24,277,'azul',3958);
call insertarRollo('liso',38,315,'cafe',2395);
call insertarRollo('regular',34,210,'rojo',2788);
call insertarRollo('sedoso',24,255,'verde',3181);
call insertarRollo('arrugado',37,243,'negro',3102);
call insertarRollo('arrugado',37,318,'naraja',3688);
call insertarRollo('sedoso',39,208,'negro',3900);
call insertarRollo('fina',42,209,'naraja',3297);
call insertarRollo('arrugado',22,268,'rojo',2780);
call insertarRollo('sedoso',18,290,'verde',3856);
call insertarRollo('arrugado',30,307,'verde',2882);
call insertarRollo('ancho',27,282,'verde',3439);
call insertarRollo('sedoso',41,284,'rojo',3474);
call insertarRollo('sedoso',39,251,'verde',3545);
call insertarRollo('arrugado',20,285,'naraja',2843);
call insertarRollo('ancho',33,329,'amarillo',2437);
call insertarRollo('regular',19,286,'rojo',2794);
call insertarRollo('ancho',41,298,'morado',3756);
call insertarRollo('ancho',21,283,'amarillo',2427);
call insertarRollo('arrugado',24,246,'morado',2504);
call insertarRollo('fina',31,309,'cafe',3390);
call insertarRollo('arrugado',34,219,'naraja',3637);
call insertarRollo('arrugado',17,316,'negro',2656);
call insertarRollo('arrugado',21,274,'azul',3232);
call insertarRollo('regular',23,218,'cafe',2399);
call insertarRollo('arrugado',34,301,'cafe',3812);
call insertarRollo('liso',22,317,'azul',3742);
call insertarRollo('sedoso',17,207,'naraja',3176);
call insertarRollo('liso',42,235,'rojo',2968);
call insertarRollo('ancho',17,326,'negro',2463);
call insertarRollo('sedoso',27,324,'blanco',2305);
call insertarRollo('fina',41,272,'cafe',3904);
call insertarRollo('popular',31,200,'azul',2916);
call insertarRollo('fina',22,279,'azul',2918);
call insertarRollo('popular',15,321,'blanco',3902);
call insertarRollo('liso',19,278,'cafe',3283);
call insertarRollo('fina',17,256,'rojo',2889);
call insertarRollo('fina',35,310,'rojo',3740);
call insertarRollo('fina',19,293,'verde',3645);
call insertarRollo('fina',41,204,'amarillo',3510);
call insertarRollo('ancho',44,275,'rojo',3472);
call insertarRollo('arrugado',34,333,'negro',2695);
call insertarRollo('liso',21,294,'blanco',3861);
call insertarRollo('popular',18,322,'verde',2633);
call insertarRollo('popular',20,306,'rojo',2995);
call insertarRollo('ancho',29,228,'cafe',3597);
call insertarRollo('popular',24,255,'negro',3551);

#select * FROM rollo;

drop  procedure if exists insertarInsumos;
delimiter $$
create procedure insertarInsumos( nombre varchar(45), precio int,cantidad int ) 
	begin
		insert into insumos(ins_nombre,ins_precio,cantidad) values(nombre,precio,cantidad);
	end ;
$$
delimiter ;

call insertarInsumos('Sezgo',100,10);
call insertarInsumos('Embone',120,33);
call insertarInsumos('Caucho',400,17);
call insertarInsumos('Bamba',500,43);
call insertarInsumos('Bolsa',540,33);
call insertarInsumos('Etiqueta',330,29);
call insertarInsumos('Talla',720,24);
call insertarInsumos('Estampado',600,46);
call insertarInsumos('Cremallera',356,43);
 
#select * FROM insumos;

drop procedure if exists insertarFabricacion;
delimiter $$
create procedure insertarFabricacion( bodegat int)
	begin
		insert into fabricacion(fab_fecha,Bodega_idBodega) values(curdate(),bodegat);
	end ;
$$
delimiter ;

call insertarFabricacion( ( select idBodega FROM bodega where idBodega=1) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=2) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=3) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=4) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=5) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=6) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=7) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=8) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=9) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=10) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=11) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=12) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=13) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=14) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=15) );
call insertarFabricacion( ( select idBodega FROM bodega where idBodega=16) );

#select * from fabricacion;


drop procedure if exists insertEmpleadoCedula;
delimiter $$
create procedure insertEmpleadoCedula(salario int, cedula int)
	begin 
		set @id =0;
		select per_id into @id from persona where per_cedula = cedula;
		if(@id=0) then
			select 'No existe la cédula' as mensaje;
		else
			insert into empleado (salario,per_id) values (salario,@id);
		end if;
	end;
$$
delimiter ;


#select * from empleado join persona using(per_id);

call insertEmpleadoCedula(800000,10008633);
call insertEmpleadoCedula(800000,10003345);
call insertEmpleadoCedula(800000,10008349);
call insertEmpleadoCedula(800000,10008458);
call insertEmpleadoCedula(800000,10009018);
call insertEmpleadoCedula(800000,10008156);
call insertEmpleadoCedula(800000,10005951);


#select * from empleado;


drop procedure if exists insertClienteCedula;
delimiter $$
create procedure insertClienteCedula(cedula int)
	begin 
		set @id =0;
		select per_id into @id from persona where per_cedula = cedula;
		if(@id=0) then
			select 'No existe la cédula' as mensaje;
		else
			insert into cliente (puntos,per_id) values (0,@id);
		end if;
	end;
$$
delimiter ;

#select * FROM persona where per_cedula=1012429484;

call insertClienteCedula(1012429484);
call insertClienteCedula(10009079);
call insertClienteCedula(10000824);
call insertClienteCedula(10004099);
call insertClienteCedula(10009937);
#select * from cliente;

drop procedure if exists insertarProveedorCedula;
delimiter $$
create procedure insertarProveedorCedula(nit int, cedula int)
	begin 
		set @id =0;
		select per_id into @id from persona where per_cedula = cedula;
		if(@id=0) then
			select 'No existe la cédula' as mensaje;
		else
			insert into proveedor (nit,Persona_per_id) values (nit,@id);
		end if;
	end;
$$
delimiter ;

call insertarProveedorCedula(10000251,10002094);
call insertarProveedorCedula(10001135, 10005323);
call insertarProveedorCedula(10005141, 10005777);
call insertarProveedorCedula(10005429, 10007073 );
call insertarProveedorCedula(10008795, 10000932);
call insertarProveedorCedula(10006998, 10006344);
call insertarProveedorCedula(10001802,10008623 );
call insertarProveedorCedula(10001777,10001874 );
call insertarProveedorCedula(10008276,10001593 );
call insertarProveedorCedula(10002615, 10004126);


drop procedure if exists insertarVenta;
delimiter $$
create procedure insertarVenta(clt int ,emp int , bdg int)
	begin
		insert into  venta(ven_fecha,Cliente_per_id,Empleado_per_id,Bodega_idBodega)  values(curdate(), clt, emp, bdg) ;
	end ;
$$
delimiter ;


call insertarVenta( ( select per_id FROM cliente where per_id=1),( select per_id FROM empleado where per_id=56),( select idBodega FROM bodega where idBodega=1) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=57),( select idBodega FROM bodega where idBodega=13) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=59),( select idBodega FROM bodega where idBodega=6) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=54),( select idBodega FROM bodega where idBodega=12) );
call insertarVenta( ( select per_id FROM cliente where per_id=90),( select per_id FROM empleado where per_id=56),( select idBodega FROM bodega where idBodega=12) );
call insertarVenta( ( select per_id FROM cliente where per_id=90),( select per_id FROM empleado where per_id=78),( select idBodega FROM bodega where idBodega=1) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=54),( select idBodega FROM bodega where idBodega=3) );
call insertarVenta( ( select per_id FROM cliente where per_id=1),( select per_id FROM empleado where per_id=78),( select idBodega FROM bodega where idBodega=8) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=55),( select idBodega FROM bodega where idBodega=1) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=57),( select idBodega FROM bodega where idBodega=10) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=57),( select idBodega FROM bodega where idBodega=3) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=78),( select idBodega FROM bodega where idBodega=6) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=58),( select idBodega FROM bodega where idBodega=13) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=59),( select idBodega FROM bodega where idBodega=5) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=59),( select idBodega FROM bodega where idBodega=16) );
call insertarVenta( ( select per_id FROM cliente where per_id=90),( select per_id FROM empleado where per_id=56),( select idBodega FROM bodega where idBodega=3) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=54),( select idBodega FROM bodega where idBodega=14) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=59),( select idBodega FROM bodega where idBodega=14) );
call insertarVenta( ( select per_id FROM cliente where per_id=90),( select per_id FROM empleado where per_id=55),( select idBodega FROM bodega where idBodega=10) );
call insertarVenta( ( select per_id FROM cliente where per_id=1),( select per_id FROM empleado where per_id=58),( select idBodega FROM bodega where idBodega=5) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=78),( select idBodega FROM bodega where idBodega=7) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=78),( select idBodega FROM bodega where idBodega=1) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=54),( select idBodega FROM bodega where idBodega=5) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=58),( select idBodega FROM bodega where idBodega=12) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=54),( select idBodega FROM bodega where idBodega=8) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=56),( select idBodega FROM bodega where idBodega=8) );
call insertarVenta( ( select per_id FROM cliente where per_id=99),( select per_id FROM empleado where per_id=78),( select idBodega FROM bodega where idBodega=12) );
call insertarVenta( ( select per_id FROM cliente where per_id=101),( select per_id FROM empleado where per_id=58),( select idBodega FROM bodega where idBodega=7) );
call insertarVenta( ( select per_id FROM cliente where per_id=1),( select per_id FROM empleado where per_id=55),( select idBodega FROM bodega where idBodega=10) );
call insertarVenta( ( select per_id FROM cliente where per_id=64),( select per_id FROM empleado where per_id=55),( select idBodega FROM bodega where idBodega=4) );

#select * from venta;

drop procedure if exists insertarDetalleVenta;
delimiter $$
create procedure insertarDetalleVenta(cnt int,venid int, idpro int)
	begin
		insert into DetalleVenta(cantidad,Venta_ven_id,Product_idProducti) values ( cnt,venid,idpro );
	end ;
$$
delimiter ;



call insertarDetalleVenta( 8866,( select ven_id FROM Venta where ven_id=17),( select idProducti FROM Product where idProducti=1) );
call insertarDetalleVenta( 14597,( select ven_id FROM Venta where ven_id=18),( select idProducti FROM Product where idProducti=57) );
call insertarDetalleVenta( 21457,( select ven_id FROM Venta where ven_id=27),( select idProducti FROM Product where idProducti=25) );
call insertarDetalleVenta( 22179,( select ven_id FROM Venta where ven_id=6),( select idProducti FROM Product where idProducti=53) );
call insertarDetalleVenta( 11080,( select ven_id FROM Venta where ven_id=16),( select idProducti FROM Product where idProducti=50) );
call insertarDetalleVenta( 12289,( select ven_id FROM Venta where ven_id=3),( select idProducti FROM Product where idProducti=2) );
call insertarDetalleVenta( 24771,( select ven_id FROM Venta where ven_id=5),( select idProducti FROM Product where idProducti=11) );
call insertarDetalleVenta( 5093,( select ven_id FROM Venta where ven_id=4),( select idProducti FROM Product where idProducti=32) );
call insertarDetalleVenta( 15633,( select ven_id FROM Venta where ven_id=12),( select idProducti FROM Product where idProducti=1) );
call insertarDetalleVenta( 17143,( select ven_id FROM Venta where ven_id=19),( select idProducti FROM Product where idProducti=40) );
call insertarDetalleVenta( 14016,( select ven_id FROM Venta where ven_id=20),( select idProducti FROM Product where idProducti=12) );
call insertarDetalleVenta( 17154,( select ven_id FROM Venta where ven_id=2),( select idProducti FROM Product where idProducti=25) );
call insertarDetalleVenta( 15398,( select ven_id FROM Venta where ven_id=25),( select idProducti FROM Product where idProducti=55) );
call insertarDetalleVenta( 19534,( select ven_id FROM Venta where ven_id=27),( select idProducti FROM Product where idProducti=22) );
call insertarDetalleVenta( 15787,( select ven_id FROM Venta where ven_id=28),( select idProducti FROM Product where idProducti=67) );
call insertarDetalleVenta( 9706,( select ven_id FROM Venta where ven_id=14),( select idProducti FROM Product where idProducti=10) );
call insertarDetalleVenta( 20593,( select ven_id FROM Venta where ven_id=7),( select idProducti FROM Product where idProducti=61) );
call insertarDetalleVenta( 24994,( select ven_id FROM Venta where ven_id=30),( select idProducti FROM Product where idProducti=60) );
call insertarDetalleVenta( 10324,( select ven_id FROM Venta where ven_id=12),( select idProducti FROM Product where idProducti=43) );
call insertarDetalleVenta( 5474,( select ven_id FROM Venta where ven_id=26),( select idProducti FROM Product where idProducti=21) );
call insertarDetalleVenta( 18544,( select ven_id FROM Venta where ven_id=3),( select idProducti FROM Product where idProducti=27) );
call insertarDetalleVenta( 23376,( select ven_id FROM Venta where ven_id=1),( select idProducti FROM Product where idProducti=4) );
call insertarDetalleVenta( 16758,( select ven_id FROM Venta where ven_id=9),( select idProducti FROM Product where idProducti=20) );
call insertarDetalleVenta( 19530,( select ven_id FROM Venta where ven_id=26),( select idProducti FROM Product where idProducti=49) );
call insertarDetalleVenta( 19875,( select ven_id FROM Venta where ven_id=7),( select idProducti FROM Product where idProducti=34) );
call insertarDetalleVenta( 23984,( select ven_id FROM Venta where ven_id=14),( select idProducti FROM Product where idProducti=33) );
call insertarDetalleVenta( 16981,( select ven_id FROM Venta where ven_id=4),( select idProducti FROM Product where idProducti=53) );
call insertarDetalleVenta( 17179,( select ven_id FROM Venta where ven_id=23),( select idProducti FROM Product where idProducti=27) );
call insertarDetalleVenta( 8031,( select ven_id FROM Venta where ven_id=11),( select idProducti FROM Product where idProducti=41) );
call insertarDetalleVenta( 21058,( select ven_id FROM Venta where ven_id=13),( select idProducti FROM Product where idProducti=16) );

#select * From DetalleVenta;

#select * from detallesFabricacion;

drop procedure if exists insertardetallesFabricacion_has_insumos;
delimiter $$
create procedure insertardetallesFabricacion_has_insumos(dtll int,inss int, cstt int, rrr int)
	begin
		insert into detallesFabricacion_has_insumos(detallesFabricacion_iddetallesFabricacion,insumos_idinsumos,costoInsumo,cantidadUsada) values (dtll,inss,cstt,rrr);
	end ;
$$
delimiter ;

call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=6 ),(select idinsumos FROM insumos where idinsumos=1 ),(select ins_precio FROM insumos where idinsumos=1)*13,13);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=15 ),(select idinsumos FROM insumos where idinsumos=8 ),(select ins_precio FROM insumos where idinsumos=8)*13,13);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=25 ),(select idinsumos FROM insumos where idinsumos=4 ),(select ins_precio FROM insumos where idinsumos=4)*19,19);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=26 ),(select idinsumos FROM insumos where idinsumos=7 ),(select ins_precio FROM insumos where idinsumos=7)*6,6);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=10 ),(select idinsumos FROM insumos where idinsumos=7 ),(select ins_precio FROM insumos where idinsumos=7)*12,12);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=11 ),(select idinsumos FROM insumos where idinsumos=1 ),(select ins_precio FROM insumos where idinsumos=1)*5,5);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=30 ),(select idinsumos FROM insumos where idinsumos=2 ),(select ins_precio FROM insumos where idinsumos=2)*6,6);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=1 ),(select idinsumos FROM insumos where idinsumos=5 ),(select ins_precio FROM insumos where idinsumos=5)*6,6);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=16 ),(select idinsumos FROM insumos where idinsumos=1 ),(select ins_precio FROM insumos where idinsumos=1)*10,10);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=19 ),(select idinsumos FROM insumos where idinsumos=6 ),(select ins_precio FROM insumos where idinsumos=6)*14,14);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=14 ),(select idinsumos FROM insumos where idinsumos=2 ),(select ins_precio FROM insumos where idinsumos=2)*15,15);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=19 ),(select idinsumos FROM insumos where idinsumos=4 ),(select ins_precio FROM insumos where idinsumos=4)*4,4);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=16 ),(select idinsumos FROM insumos where idinsumos=8 ),(select ins_precio FROM insumos where idinsumos=8)*17,17);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=22 ),(select idinsumos FROM insumos where idinsumos=3 ),(select ins_precio FROM insumos where idinsumos=3)*18,18);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=17 ),(select idinsumos FROM insumos where idinsumos=9 ),(select ins_precio FROM insumos where idinsumos=9)*19,19);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=8 ),(select idinsumos FROM insumos where idinsumos=2 ),(select ins_precio FROM insumos where idinsumos=2)*11,11);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=24 ),(select idinsumos FROM insumos where idinsumos=8 ),(select ins_precio FROM insumos where idinsumos=8)*7,7);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=30 ),(select idinsumos FROM insumos where idinsumos=8 ),(select ins_precio FROM insumos where idinsumos=8)*20,20);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=8 ),(select idinsumos FROM insumos where idinsumos=6 ),(select ins_precio FROM insumos where idinsumos=6)*10,10);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=1 ),(select idinsumos FROM insumos where idinsumos=3 ),(select ins_precio FROM insumos where idinsumos=3)*18,18);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=21 ),(select idinsumos FROM insumos where idinsumos=4 ),(select ins_precio FROM insumos where idinsumos=4)*5,5);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=28 ),(select idinsumos FROM insumos where idinsumos=1 ),(select ins_precio FROM insumos where idinsumos=1)*4,4);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=18 ),(select idinsumos FROM insumos where idinsumos=3 ),(select ins_precio FROM insumos where idinsumos=3)*8,8);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=22 ),(select idinsumos FROM insumos where idinsumos=7 ),(select ins_precio FROM insumos where idinsumos=7)*18,18);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=23 ),(select idinsumos FROM insumos where idinsumos=5 ),(select ins_precio FROM insumos where idinsumos=5)*7,7);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=29 ),(select idinsumos FROM insumos where idinsumos=5 ),(select ins_precio FROM insumos where idinsumos=5)*11,11);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=18 ),(select idinsumos FROM insumos where idinsumos=7 ),(select ins_precio FROM insumos where idinsumos=7)*5,5);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=19 ),(select idinsumos FROM insumos where idinsumos=4 ),(select ins_precio FROM insumos where idinsumos=4)*16,16);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=5 ),(select idinsumos FROM insumos where idinsumos=6 ),(select ins_precio FROM insumos where idinsumos=6)*10,10);
call insertardetallesFabricacion_has_insumos( (select iddetallesFabricacion FROM detallesFabricacion where iddetallesFabricacion=25 ),(select idinsumos FROM insumos where idinsumos=3 ),(select ins_precio FROM insumos where idinsumos=3)*11,11);


#select * from detallesFabricacion_has_insumos;

drop procedure if exists insertarRegistroProvee;
delimiter :*
create procedure insertarRegistroProvee(rolloId int, idProveedor int )
	begin
			set @rollo = -1;
			set @prov = -1;
			select idRollo into @rollo from rollo where idRollo = rolloId limit 1;
			select Persona_per_id into @prov from proveedor where Persona_per_id = idProveedor;
			if(@rollo != -1 and @prov != -1) then
				insert into provee (Rollo_idRollo,Proveedor_Persona_per_id) values (@rollo,@prov); 
			elseif(@rollo = -1) then
				select 'Rollo no existe' as mensaje;
			else	
				select 'Proveedor no existe' as mensaje;
			end if;
	end;
:*
delimiter ;

#select * from rollo;
#select * from proveedor;

#select * from provee;

call insertarRegistroProvee(42,69);
call insertarRegistroProvee(89,68);
call insertarRegistroProvee(81,73);
call insertarRegistroProvee(12,73);
call insertarRegistroProvee(65,74);
call insertarRegistroProvee(72,67);
call insertarRegistroProvee(27,71);
call insertarRegistroProvee(83,76);
call insertarRegistroProvee(82,67);
call insertarRegistroProvee(1,71);
call insertarRegistroProvee(37,74);
call insertarRegistroProvee(44,71);
call insertarRegistroProvee(90,72);
call insertarRegistroProvee(40,67);
call insertarRegistroProvee(36,74);
call insertarRegistroProvee(43,75);
call insertarRegistroProvee(91,75);
call insertarRegistroProvee(14,72);
call insertarRegistroProvee(31,67);
call insertarRegistroProvee(34,69);
call insertarRegistroProvee(24,74);
call insertarRegistroProvee(53,72);
call insertarRegistroProvee(51,68);
call insertarRegistroProvee(93,73);
call insertarRegistroProvee(61,72);
call insertarRegistroProvee(78,70);
call insertarRegistroProvee(64,67);
call insertarRegistroProvee(66,74);
call insertarRegistroProvee(49,67);
call insertarRegistroProvee(62,75);
call insertarRegistroProvee(26,73);
call insertarRegistroProvee(25,72);
call insertarRegistroProvee(20,74);
call insertarRegistroProvee(39,74);
call insertarRegistroProvee(17,71);
call insertarRegistroProvee(46,74);
call insertarRegistroProvee(95,75);
call insertarRegistroProvee(97,71);
call insertarRegistroProvee(23,76);
call insertarRegistroProvee(3,76);
call insertarRegistroProvee(13,70);
call insertarRegistroProvee(28,75);
call insertarRegistroProvee(79,73);
#select * from provee;



drop procedure if exists proveeInsumo;
delimiter $$
create procedure proveeInsumo(idInsumo int ,idProveedor int ,cantidad int)
	begin
			set @insumo = -1;
			set @prov = -1;
			select idinsumos into @insumo from insumos where idInsumos = idInsumo limit 1;
			select Persona_per_id into @prov from proveedor where Persona_per_id = idProveedor;
			if(@insumo != -1 and @prov != -1) then
				insert into proveeinsumo (insumos_idinsumos,Proveedor_Persona_per_id,cantidad) values (@insumo,@prov,cantidad); 
			elseif(@insumo = -1) then
				select 'insumo no existe' as mensaje;
			else	
				select 'Proveedor no existe' as mensaje;
			end if;
	end;
$$
delimiter ;

select * from proveeinsumo;

call proveeInsumo(1,67,7);
call proveeInsumo(5,71,18);
call proveeInsumo(8,69,92);
call proveeInsumo(7,71,44);
call proveeInsumo(4,73,51);
call proveeInsumo(2,72,31);
call proveeInsumo(4,76,67);
call proveeInsumo(4,72,47);
call proveeInsumo(6,69,33);
call proveeInsumo(2,68,77);
call proveeInsumo(5,67,24);
call proveeInsumo(1,72,65);
call proveeInsumo(5,70,51);
call proveeInsumo(8,70,29);
call proveeInsumo(1,69,74);
call proveeInsumo(7,69,16);
call proveeInsumo(5,71,55);
call proveeInsumo(4,70,36);
call proveeInsumo(2,71,22);
call proveeInsumo(7,72,58);
call proveeInsumo(1,69,17);
call proveeInsumo(3,73,84);
call proveeInsumo(2,76,7);
call proveeInsumo(7,70,86);
call proveeInsumo(5,76,94);
call proveeInsumo(2,71,38);
call proveeInsumo(4,75,25);
call proveeInsumo(1,67,90);
call proveeInsumo(3,71,58);
call proveeInsumo(6,74,83);
call proveeInsumo(1,75,88);
call proveeInsumo(3,74,47);
call proveeInsumo(1,75,79);
call proveeInsumo(4,75,95);
call proveeInsumo(6,71,20);
call proveeInsumo(6,74,77);
call proveeInsumo(5,76,88);
call proveeInsumo(6,72,23);
call proveeInsumo(1,70,33);
call proveeInsumo(1,67,13);
call proveeInsumo(6,67,81);
call proveeInsumo(2,68,95);
call proveeInsumo(7,71,3);
call proveeInsumo(5,67,14);
call proveeInsumo(1,71,10);
call proveeInsumo(7,73,35);
call proveeInsumo(3,70,77);
call proveeInsumo(3,67,73);
call proveeInsumo(4,67,82);
call proveeInsumo(1,68,48);


#select * from detalleventa where Venta_ven_id = 1 ;

drop procedure if exists insertarMercado;
delimiter $$
create procedure insertarMercado(fe date)
	begin
		set @var =0;
		select mer_id into @var from mercado order by mer_id desc limit 1;
		set @count = -1; 
		select mer_id from mercado where fecha = fe limit 1 into @count; 
		if(@count != -1) then
			select 'No se permiten dos mercados en la misma fecha.';
		else
			insert into mercado (fecha,Mercado_mer_id) values (fe, @var);
			select 'Mercado agregado con éxito';
		end if;
	end;
$$
delimiter ;

#select * from mercado;
#delete from mercadohasproduct where Mercado_mer_id = 7; 
#delete from mercado where mer_id = 7;

call insertarPersona('Administrador',1,'Carrera 1 calle 1',0,'1234');
call insertEmpleadoCedula(1,1);

drop trigger if exists mercadoInventario;
delimiter %%
create trigger mercadoInventario AFTER INSERT ON mercado
	for each row begin
		set @id = NEW.mer_id;
		set @anterior = NEW.Mercado_mer_id;
		set @productos = 0; select count(*) into @productos from product; 
		set @counter = 1;
		set @oldQuantity = 0;
		while @counter <= @productos DO
			select cantidad_final into @oldQuantity from mercadohasproduct where Mercado_mer_id = @anterior and Product_idProducti=@counter;
			insert into mercadohasproduct (cantidad_inicial,cantidad_final,cantidad_agregada,Mercado_mer_id,Product_idProducti) 
					values (@oldQuantity,@oldQuantity,0,@id,@counter);
			set @counter = @counter +1 ;
		end while;
	end
%%
delimiter ;

#Creando el mercado base
insert into mercado (fecha,Mercado_mer_id) values (current_date,null);
call insertarMercado(current_date);

#select * from mercado;
#Resetando el contador
#ALTER TABLE mercado AUTO_INCREMENT = 1;

#select * from mercadohasproduct where Mercado_mer_id =2 ;


drop procedure if exists llevarMadrugon;
delimiter :*
create procedure llevarMadrugon (mer_id int, pro_id int, cantidad int)
	begin
		update mercadoHasProduct set cantidad_agregada = cantidad, cantidad_final = cantidad_inicial+cantidad 
			where Mercado_mer_id = mer_id and Product_idProducti = pro_id;
	end;
:*
delimiter ;

#select * from mercadoHasProduct; 

#Inserting data of the 0 madrugon ***********************************************
call llevarMadrugon(1,1,18);
call llevarMadrugon(1,2,3);
call llevarMadrugon(1,3,6);
call llevarMadrugon(1,4,9);
call llevarMadrugon(1,5,6);
call llevarMadrugon(1,6,16);
call llevarMadrugon(1,7,16);
call llevarMadrugon(1,8,16);
call llevarMadrugon(1,9,23);
call llevarMadrugon(1,10,16);
call llevarMadrugon(1,11,16);
call llevarMadrugon(1,12,13);
call llevarMadrugon(1,13,13);
call llevarMadrugon(1,14,13);
call llevarMadrugon(1,15,14);
call llevarMadrugon(1,16,18);
call llevarMadrugon(1,17,13);
call llevarMadrugon(1,18,8);
call llevarMadrugon(1,19,14);
call llevarMadrugon(1,20,8);
call llevarMadrugon(1,21,5);
call llevarMadrugon(1,22,12);
call llevarMadrugon(1,23,9);
call llevarMadrugon(1,24,10);
call llevarMadrugon(1,25,71);
call llevarMadrugon(1,26,65);
call llevarMadrugon(1,27,49);
call llevarMadrugon(1,28,48);
call llevarMadrugon(1,29,14);
call llevarMadrugon(1,30,21);
call llevarMadrugon(1,31,20);
call llevarMadrugon(1,32,19);
call llevarMadrugon(1,33,21);
call llevarMadrugon(1,34,18);
call llevarMadrugon(1,35,16);
call llevarMadrugon(1,36,17);
call llevarMadrugon(1,37,10);
call llevarMadrugon(1,38,12);
call llevarMadrugon(1,39,16);
call llevarMadrugon(1,40,22);
call llevarMadrugon(1,41,10);
call llevarMadrugon(1,42,29);
call llevarMadrugon(1,43,26);
call llevarMadrugon(1,44,26);
call llevarMadrugon(1,45,23);
call llevarMadrugon(1,46,26);
call llevarMadrugon(1,47,27);
call llevarMadrugon(1,48,7);
call llevarMadrugon(1,49,4);
call llevarMadrugon(1,50,4);
call llevarMadrugon(1,51,17);
call llevarMadrugon(1,52,11);
call llevarMadrugon(1,53,12);
call llevarMadrugon(1,54,9);
call llevarMadrugon(1,55,8);
call llevarMadrugon(1,56,8);
call llevarMadrugon(1,57,1);
call llevarMadrugon(1,58,11);
call llevarMadrugon(1,59,12);
call llevarMadrugon(1,60,0);
call llevarMadrugon(1,61,11);
call llevarMadrugon(1,62,9);
call llevarMadrugon(1,63,10);
call llevarMadrugon(1,64,0);
#Inserting data of the 0 madrugon ***********************************************


#Inserting data of the first madrugon *******************************************************
call llevarMadrugon(2,1,3);
call llevarMadrugon(2,2,24);
call llevarMadrugon(2,3,25);
call llevarMadrugon(2,4,25);
call llevarMadrugon(2,5,0);
call llevarMadrugon(2,6,0);
call llevarMadrugon(2,7,0);
call llevarMadrugon(2,8,0);
call llevarMadrugon(2,9,7);
call llevarMadrugon(2,10,13);
call llevarMadrugon(2,11,0);
call llevarMadrugon(2,12,0);
call llevarMadrugon(2,13,0);
call llevarMadrugon(2,14,0);
call llevarMadrugon(2,15,0);
call llevarMadrugon(2,16,0);
call llevarMadrugon(2,17,0);
call llevarMadrugon(2,18,4);
call llevarMadrugon(2,19,3);
call llevarMadrugon(2,20,5);
call llevarMadrugon(2,21,2);
call llevarMadrugon(2,22,2);
call llevarMadrugon(2,23,7);
call llevarMadrugon(2,24,12);
call llevarMadrugon(2,25,10);
call llevarMadrugon(2,26,30);
call llevarMadrugon(2,27,49);
call llevarMadrugon(2,28,26);
call llevarMadrugon(2,29,2);
call llevarMadrugon(2,30,6);
call llevarMadrugon(2,31,9);
call llevarMadrugon(2,32,11);
call llevarMadrugon(2,33,0);
call llevarMadrugon(2,34,0);
call llevarMadrugon(2,35,0);
call llevarMadrugon(2,36,0);
call llevarMadrugon(2,37,0);
call llevarMadrugon(2,38,0);
call llevarMadrugon(2,39,0);
call llevarMadrugon(2,40,10);
call llevarMadrugon(2,41,13);
call llevarMadrugon(2,42,0);
call llevarMadrugon(2,43,0);
call llevarMadrugon(2,44,0);
call llevarMadrugon(2,45,0);
call llevarMadrugon(2,46,0);
call llevarMadrugon(2,47,-1);
call llevarMadrugon(2,48,0);
call llevarMadrugon(2,49,2);
call llevarMadrugon(2,50,2);
call llevarMadrugon(2,51,0);
call llevarMadrugon(2,52,0);
call llevarMadrugon(2,53,0);
call llevarMadrugon(2,54,8);
call llevarMadrugon(2,55,5);
call llevarMadrugon(2,56,8);
call llevarMadrugon(2,57,0);
call llevarMadrugon(2,58,0);
call llevarMadrugon(2,59,6);
call llevarMadrugon(2,60,0);
call llevarMadrugon(2,61,0);
call llevarMadrugon(2,62,0);
call llevarMadrugon(2,63,0);
call llevarMadrugon(2,64,0);

#*********************************************************************************************

#select * from mercadohasproduct where Mercado_mer_id =2;


#####################################################################################################################################################


drop trigger if exists checkUpdate;
delimiter :*
create trigger checkUpdate before update on product_has_bodega
	for each row begin
		if(new.cantidad<0) then 
				call No_hay_cantidad_suficiente_no_puede_quedar_negativa_las_existencias_en_la_bodega();
		end if;
	end;
:*
delimiter ;

drop procedure if exists actualiza;
delimiter $$
create procedure actualiza(idproductt int , idbodegat int, cnt int )
	begin
		update product_has_bodega set cantidad = cantidad + cnt where Product_idProducti = idproductt and Bodega_idBodega = idbodegat;
	end ;
$$
delimiter ;

#21,1,-17

select * from product_has_bodega;

select * from product_has_bodega;

call actualiza(1,10,15);
call actualiza(57,10,21);
call actualiza(25,15,27);
call actualiza(53,3,28);
call actualiza(50,9,17);
call actualiza(2,2,18);
call actualiza(11,3,30);
call actualiza(32,2,12);
call actualiza(1,7,22);
call actualiza(40,10,23);
call actualiza(12,11,20);
call actualiza(25,1,23);
call actualiza(55,13,21);
call actualiza(22,15,25);
call actualiza(67,15,22);
call actualiza(10,8,16);
call actualiza(61,4,26);
call actualiza(60,16,30);
call actualiza(43,7,17);
call actualiza(21,14,12);
call actualiza(27,2,24);
call actualiza(4,1,29);
call actualiza(20,5,23);
call actualiza(49,14,25);
call actualiza(34,4,26);
call actualiza(33,8,30);
call actualiza(53,2,23);
call actualiza(27,12,23);
call actualiza(41,6,14);
call actualiza(16,7,27);
call actualiza(37,16,26);
call actualiza(25,3,24);
call actualiza(35,2,25);
call actualiza(36,3,30);
call actualiza(10,15,25);
call actualiza(22,7,13);
call actualiza(68,11,14);
call actualiza(62,14,23);
call actualiza(14,3,27);
call actualiza(34,3,21);
call actualiza(52,7,17);
call actualiza(40,11,26);
call actualiza(51,8,14);
call actualiza(26,14,12);
call actualiza(37,11,20);
call actualiza(8,16,29);
call actualiza(39,6,20);
call actualiza(27,14,18);
call actualiza(32,5,30);
call actualiza(21,12,22);
call actualiza(14,13,27);
call actualiza(28,9,28);
call actualiza(2,16,22);
call actualiza(4,9,15);
call actualiza(60,11,24);
call actualiza(14,14,14);
call actualiza(8,12,17);
call actualiza(66,5,18);
call actualiza(10,12,27);
call actualiza(50,10,26);
call actualiza(18,3,12);
call actualiza(5,13,28);
call actualiza(15,2,22);
call actualiza(1,2,20);
call actualiza(53,11,22);
call actualiza(6,7,15);
call actualiza(49,5,20);
call actualiza(17,10,22);
call actualiza(45,3,21);
call actualiza(68,12,29);
call actualiza(14,6,15);
call actualiza(70,8,30);
call actualiza(7,11,13);
call actualiza(31,15,12);
call actualiza(63,5,16);
call actualiza(54,7,15);
call actualiza(44,10,20);
call actualiza(33,10,24);
call actualiza(60,14,23);
call actualiza(51,10,19);
call actualiza(13,12,22);
call actualiza(64,4,15);
call actualiza(43,12,23);
call actualiza(25,8,13);
call actualiza(52,10,23);
call actualiza(49,13,14);
call actualiza(41,14,29);
call actualiza(44,12,12);
call actualiza(47,16,17);
call actualiza(40,5,15);
call actualiza(8,14,28);
call actualiza(23,2,13);
call actualiza(45,14,22);
call actualiza(32,7,17);
call actualiza(33,9,14);
call actualiza(23,12,17);
call actualiza(58,16,28);
call actualiza(51,5,29);
call actualiza(9,2,26);



drop procedure if exists insertardetallesFabricacion;
delimiter $$
create procedure insertardetallesFabricacion(cnt int , cstins int, FBid int,PRid int, RLid int , cstins2 int)
	begin
		set @pro = -1;
		select idProducti into @pro from product where idProducti = FBid;
		if(@pro = -1) then
			select 'Producto no existe' as mensaje;
		else
			insert into detallesFabricacion(cantidad,costoInsumos,Fabricacion_idFabricacion,Product_idProducti,Rollo_idRollo,costoRollo) values(cnt,cstins,FBid,PRid,RLid,cstins2);
			set @bodega =  -1;
			select Bodega_idBodega into @bodega from fabricacion where idFabricacion = FBid;
			call actualiza(PRid,@bodega,cnt);
		end if;
	end ;
$$
delimiter ;



call insertardetallesFabricacion( 4,( select ins_precio FROM insumos where idinsumos=5)*8,( select idFabricacion FROM fabricacion where idFabricacion=13),( select idProducti FROM product where idProducti=14),( select idRollo FROM rollo where idRollo=57),( select rol_precioKilogramo FROM rollo where idRollo=57)*4 );
call insertardetallesFabricacion( 6,( select ins_precio FROM insumos where idinsumos=8)*5,( select idFabricacion FROM fabricacion where idFabricacion=12),( select idProducti FROM product where idProducti=58),( select idRollo FROM rollo where idRollo=90),( select rol_precioKilogramo FROM rollo where idRollo=90)*6 );
call insertardetallesFabricacion( 8,( select ins_precio FROM insumos where idinsumos=4)*4,( select idFabricacion FROM fabricacion where idFabricacion=1),( select idProducti FROM product where idProducti=22),( select idRollo FROM rollo where idRollo=52),( select rol_precioKilogramo FROM rollo where idRollo=52)*8 );
call insertardetallesFabricacion( 5,( select ins_precio FROM insumos where idinsumos=1)*4,( select idFabricacion FROM fabricacion where idFabricacion=8),( select idProducti FROM product where idProducti=70),( select idRollo FROM rollo where idRollo=17),( select rol_precioKilogramo FROM rollo where idRollo=17)*5 );
call insertardetallesFabricacion( 4,( select ins_precio FROM insumos where idinsumos=6)*8,( select idFabricacion FROM fabricacion where idFabricacion=10),( select idProducti FROM product where idProducti=38),( select idRollo FROM rollo where idRollo=38),( select rol_precioKilogramo FROM rollo where idRollo=38)*4 );
call insertardetallesFabricacion( 5,( select ins_precio FROM insumos where idinsumos=6)*4,( select idFabricacion FROM fabricacion where idFabricacion=6),( select idProducti FROM product where idProducti=32),( select idRollo FROM rollo where idRollo=67),( select rol_precioKilogramo FROM rollo where idRollo=67)*5 );
call insertardetallesFabricacion( 9,( select ins_precio FROM insumos where idinsumos=7)*10,( select idFabricacion FROM fabricacion where idFabricacion=5),( select idProducti FROM product where idProducti=37),( select idRollo FROM rollo where idRollo=81),( select rol_precioKilogramo FROM rollo where idRollo=81)*9 );
call insertardetallesFabricacion( 10,( select ins_precio FROM insumos where idinsumos=3)*7,( select idFabricacion FROM fabricacion where idFabricacion=3),( select idProducti FROM product where idProducti=38),( select idRollo FROM rollo where idRollo=93),( select rol_precioKilogramo FROM rollo where idRollo=93)*10 );
call insertardetallesFabricacion( 10,( select ins_precio FROM insumos where idinsumos=9)*10,( select idFabricacion FROM fabricacion where idFabricacion=14),( select idProducti FROM product where idProducti=55),( select idRollo FROM rollo where idRollo=21),( select rol_precioKilogramo FROM rollo where idRollo=21)*10 );
call insertardetallesFabricacion( 8,( select ins_precio FROM insumos where idinsumos=1)*9,( select idFabricacion FROM fabricacion where idFabricacion=5),( select idProducti FROM product where idProducti=19),( select idRollo FROM rollo where idRollo=40),( select rol_precioKilogramo FROM rollo where idRollo=40)*8 );
call insertardetallesFabricacion( 6,( select ins_precio FROM insumos where idinsumos=9)*4,( select idFabricacion FROM fabricacion where idFabricacion=1),( select idProducti FROM product where idProducti=48),( select idRollo FROM rollo where idRollo=10),( select rol_precioKilogramo FROM rollo where idRollo=10)*6 );
call insertardetallesFabricacion( 5,( select ins_precio FROM insumos where idinsumos=7)*9,( select idFabricacion FROM fabricacion where idFabricacion=12),( select idProducti FROM product where idProducti=42),( select idRollo FROM rollo where idRollo=28),( select rol_precioKilogramo FROM rollo where idRollo=28)*5 );
call insertardetallesFabricacion( 7,( select ins_precio FROM insumos where idinsumos=9)*7,( select idFabricacion FROM fabricacion where idFabricacion=8),( select idProducti FROM product where idProducti=53),( select idRollo FROM rollo where idRollo=21),( select rol_precioKilogramo FROM rollo where idRollo=21)*7 );
call insertardetallesFabricacion( 9,( select ins_precio FROM insumos where idinsumos=6)*9,( select idFabricacion FROM fabricacion where idFabricacion=7),( select idProducti FROM product where idProducti=42),( select idRollo FROM rollo where idRollo=11),( select rol_precioKilogramo FROM rollo where idRollo=11)*9 );
call insertardetallesFabricacion( 8,( select ins_precio FROM insumos where idinsumos=8)*6,( select idFabricacion FROM fabricacion where idFabricacion=4),( select idProducti FROM product where idProducti=11),( select idRollo FROM rollo where idRollo=37),( select rol_precioKilogramo FROM rollo where idRollo=37)*8 );
call insertardetallesFabricacion( 7,( select ins_precio FROM insumos where idinsumos=6)*5,( select idFabricacion FROM fabricacion where idFabricacion=6),( select idProducti FROM product where idProducti=53),( select idRollo FROM rollo where idRollo=99),( select rol_precioKilogramo FROM rollo where idRollo=99)*7 );
call insertardetallesFabricacion( 7,( select ins_precio FROM insumos where idinsumos=9)*5,( select idFabricacion FROM fabricacion where idFabricacion=9),( select idProducti FROM product where idProducti=49),( select idRollo FROM rollo where idRollo=7),( select rol_precioKilogramo FROM rollo where idRollo=7)*7 );
call insertardetallesFabricacion( 4,( select ins_precio FROM insumos where idinsumos=1)*6,( select idFabricacion FROM fabricacion where idFabricacion=5),( select idProducti FROM product where idProducti=49),( select idRollo FROM rollo where idRollo=91),( select rol_precioKilogramo FROM rollo where idRollo=91)*4 );
call insertardetallesFabricacion( 10,( select ins_precio FROM insumos where idinsumos=6)*9,( select idFabricacion FROM fabricacion where idFabricacion=15),( select idProducti FROM product where idProducti=11),( select idRollo FROM rollo where idRollo=69),( select rol_precioKilogramo FROM rollo where idRollo=69)*10 );
call insertardetallesFabricacion( 5,( select ins_precio FROM insumos where idinsumos=5)*5,( select idFabricacion FROM fabricacion where idFabricacion=8),( select idProducti FROM product where idProducti=58),( select idRollo FROM rollo where idRollo=18),( select rol_precioKilogramo FROM rollo where idRollo=18)*5 );
call insertardetallesFabricacion( 9,( select ins_precio FROM insumos where idinsumos=7)*8,( select idFabricacion FROM fabricacion where idFabricacion=10),( select idProducti FROM product where idProducti=20),( select idRollo FROM rollo where idRollo=41),( select rol_precioKilogramo FROM rollo where idRollo=41)*9 );
call insertardetallesFabricacion( 9,( select ins_precio FROM insumos where idinsumos=1)*9,( select idFabricacion FROM fabricacion where idFabricacion=6),( select idProducti FROM product where idProducti=9),( select idRollo FROM rollo where idRollo=48),( select rol_precioKilogramo FROM rollo where idRollo=48)*9 );
call insertardetallesFabricacion( 7,( select ins_precio FROM insumos where idinsumos=9)*10,( select idFabricacion FROM fabricacion where idFabricacion=2),( select idProducti FROM product where idProducti=30),( select idRollo FROM rollo where idRollo=67),( select rol_precioKilogramo FROM rollo where idRollo=67)*7 );
call insertardetallesFabricacion( 7,( select ins_precio FROM insumos where idinsumos=3)*9,( select idFabricacion FROM fabricacion where idFabricacion=6),( select idProducti FROM product where idProducti=34),( select idRollo FROM rollo where idRollo=35),( select rol_precioKilogramo FROM rollo where idRollo=35)*7 );
call insertardetallesFabricacion( 7,( select ins_precio FROM insumos where idinsumos=6)*9,( select idFabricacion FROM fabricacion where idFabricacion=5),( select idProducti FROM product where idProducti=69),( select idRollo FROM rollo where idRollo=28),( select rol_precioKilogramo FROM rollo where idRollo=28)*7 );
call insertardetallesFabricacion( 5,( select ins_precio FROM insumos where idinsumos=9)*7,( select idFabricacion FROM fabricacion where idFabricacion=7),( select idProducti FROM product where idProducti=59),( select idRollo FROM rollo where idRollo=77),( select rol_precioKilogramo FROM rollo where idRollo=77)*5 );
call insertardetallesFabricacion( 4,( select ins_precio FROM insumos where idinsumos=2)*7,( select idFabricacion FROM fabricacion where idFabricacion=1),( select idProducti FROM product where idProducti=41),( select idRollo FROM rollo where idRollo=100),( select rol_precioKilogramo FROM rollo where idRollo=100)*4 );
call insertardetallesFabricacion( 9,( select ins_precio FROM insumos where idinsumos=2)*9,( select idFabricacion FROM fabricacion where idFabricacion=4),( select idProducti FROM product where idProducti=47),( select idRollo FROM rollo where idRollo=63),( select rol_precioKilogramo FROM rollo where idRollo=63)*9 );
call insertardetallesFabricacion( 4,( select ins_precio FROM insumos where idinsumos=4)*6,( select idFabricacion FROM fabricacion where idFabricacion=16),( select idProducti FROM product where idProducti=22),( select idRollo FROM rollo where idRollo=75),( select rol_precioKilogramo FROM rollo where idRollo=75)*4 );
call insertardetallesFabricacion( 4,( select ins_precio FROM insumos where idinsumos=7)*8,( select idFabricacion FROM fabricacion where idFabricacion=12),( select idProducti FROM product where idProducti=59),( select idRollo FROM rollo where idRollo=74),( select rol_precioKilogramo FROM rollo where idRollo=74)*4 );


drop procedure if exists nuevaRemision;
delimiter %%
create procedure nuevaRemision(remitente int ,receptor int)
	begin
		set @remi = 0;
		set @rece = 0;
		select idBodega into @remi from bodega where idBodega = remitente;
		select idBodega into @rece from bodega where idBodega = receptor;
		if(@remi != 0 and @rece !=0) then
			insert into remision (rem_fecha,Bodega_recibe,Bodega_idBodega) values (current_date(),receptor,remitente);
		end if;
	end;
%%
delimiter ;

select * from remision;
#select  * from bodega;

#select * from remision;

call nuevaRemision(1,3);
call nuevaRemision(2,4);
call nuevaRemision(1,4);
call nuevaRemision(1,4);
call nuevaRemision(1,4);

#select * from product_has_bodega where Bodega_idBodega = 3;

drop procedure if exists insertarDetalleRemision;
delimiter $$
create procedure insertarDetalleRemision(idRem int, cnt int , idPro int)
	begin
		start transaction;
		
		set @canAux=-1;
		set @canAuxNew=-1;

		set @precio = -1;
		set @remision = -1;
		select idRemision into @remision from Remision where idRemision = idRem limit 1; 
		select pro_precioVenta into @precio from product where idProducti = idPro limit 1;
		SAVEPOINT A;
		
		

		if(@precio != -1 and @remision != -1) then
			insert into DetalleRemision(det_cantidad,det_precio,Product_idProducti,Remision_idRemision) values ( cnt,@precio,idpro,@remision);
			set @bod1 = -1;
			set @bod2 = -1;
			select Bodega_recibe,Bodega_idBodega into @bod1,@bod2 from remision where idRemision = idRem;  
			set @canAux=(select cantidad from Product_has_Bodega where Bodega_idBodega=@bod2 and Product_idProducti=idPro limit 1);

			set @cantidadDisponible = -1;
			select cantidad  into @cantidadDisponible from product_has_bodega where Bodega_idBodega = @bod2 and idpro = Product_idProducti  ;

			if(@cantidadDisponible-cnt >= 0) then
				call actualiza(idPro,@bod1,cnt );
				call actualiza(idPro,@bod2,-cnt);
				
				set @canAuxNew=(select cantidad from Product_has_Bodega where Bodega_idBodega=@bod2 and Product_idProducti=idPro limit 1);
				if(  @canAux=@canAuxNew) then
					delete from detalleRemision where Remision_idRemision = idRem;
					delete from remision where idRemision = idRem;
					rollback to savepoint A;
				end if;
				select 'La remision se ha agregado correctamente';
				commit;
			else 
				select 'No hay suficientes productos';
				rollback;
			end if;
		elseif (@precio = -1) then
			select 'Producto remision no existe' as mensaje;
		else
			select 'remision no existe' as mensaje;
		end if;
	end;
$$
delimiter ;

select * from DetalleRemision;
select * from remision;


call inventario(1);
#insertarDetalleRemision(idRem int, cnt int , idPro int)
call insertarDetalleRemision(1,11,1);
call insertarDetalleRemision(1,10,2);
call insertarDetalleRemision(1,14,3);
call insertarDetalleRemision(1,16,4);
call insertarDetalleRemision(1,16,5);
call insertarDetalleRemision(1,13,6);
call insertarDetalleRemision(1,21,7);
call insertarDetalleRemision(1,21,8);
call insertarDetalleRemision(1,24,9);
call insertarDetalleRemision(1,30,36);
call insertarDetalleRemision(1,13,22);
call insertarDetalleRemision(1,1,23);
call insertarDetalleRemision(1,4,24);
call insertarDetalleRemision(1,5,25);
call insertarDetalleRemision(1,12,30);
call insertarDetalleRemision(1,9,49);

#select Bodega_recibe,Bodega_idBodega  from remision where idRemision = 1;  


#select * from remision;
select * from detalleRemision;

CREATE USER 'Gerente'@'localhost' IDENTIFIED BY '1234';

CREATE USER 'Cliente'@'localhost' IDENTIFIED BY '1234';

CREATE USER 'Empleado'@'localhost' IDENTIFIED BY '1234';

CREATE USER 'Proveedor'@'localhost' IDENTIFIED BY '1234';

#select * from mysql.user;

show grants for Gerente@localhost;

grant execute on Cibernetic3.* to 'Gerente'@'localhost';  

grant execute on Cibernetic3.buyProduct to 'Cliente'@'localhost' identified by '1234';



select * from mercado;
select * from mercadohasproduct;

call insertarMercado('2014/12/10');



