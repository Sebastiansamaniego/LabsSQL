--01.Visualizar todos los registros de la tabla productos.
  SELECT * FROM PRODUCTION.Product;
  GO

--02.Ver la estructura de la tabla productos.
EXEC sp_help 'PRODUCT'
GO

--03.Cuantos productos no pertenecen a una subcategoría.
SELECT *
FROM 
Production.Product
WHERE
ProductSubcategoryID IS NULL
GO

--04.Ver listado de subcategorías de productos
SELECT 
pp.name AS 'PRODUCTO',
ps.name AS 'SUBCATEGORIA'
FROM 
Production.Product pp
INNER JOIN
Production.ProductSubcategory ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GO

--05.Visualizar listado de subcategorías con sus respectivas categorías
SELECT 
ps.name AS 'Subcategoria',
pc.name AS 'Categoria' 
FROM 
Production.ProductSubcategory ps
INNER JOIN Production.ProductCategory pc
ON 
ps.ProductCategoryID = pc.ProductCategoryID
GO

--06.-Visualizar cantidad de productos por cada subcategoría
SELECT 
DISTINCT COUNT(pp.ProductID) as 'Producto', 
ps.name AS 'Subcategoria' 
FROM Production.Product pp
INNER JOIN Production.ProductSubcategory ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.name
GO

--7. Ver precio promedio por cada categoría de producto
SELECT pc.name AS 'Categoria',
AVG(pp.ListPrice) AS 'Precio Promedio'
FROM Production.Product pp
INNER JOIN Production.ProductSubcategory ps
ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc
ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.name
GO

--8. Ver cantidad de productos por categoría
SELECT C.Name AS Categoria,
COUNT(P.ProductID) AS CANTIDAD 
FROM Production.Product P
INNER JOIN Production.ProductSubcategory S 
on S.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN Production.ProductCategory C 
on C.ProductCategoryID = S.ProductCategoryID
GROUP BY C.Name
GO

--9. Ver cantidad de productos sólo de la categoría components
SELECT 
C.Name AS Categoria,
COUNT(P.ProductID) AS CANTIDAD 
FROM Production.Product P
INNER JOIN Production.ProductSubcategory S 
on S.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN Production.ProductCategory C 
on C.ProductCategoryID = S.ProductCategoryID
WHERE C.Name = 'Components'
GROUP BY C.Name
GO

--10. Visualizar el total de ventas por cada categoría de producto
SELECT C.Name, 
SUM(SA.LineTotal * SA.UnitPrice) as TOTAL
FROM Production.Product P
INNER JOIN Sales.SalesOrderDetail SA 
on P.ProductID = SA.ProductID
INNER JOIN Production.ProductSubcategory S 
on S.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN Production.ProductCategory C 
on C.ProductCategoryID = S.ProductCategoryID
GROUP BY C.Name
GO

--11. Ver la cantidad total de empleados
SELECT 
COUNT(H.BusinessEntityID) AS TOTAL_EMPLEADOS 
FROM 
HumanResources.Employee H;
GO

--12. Ver la cantidad total de empleados de acuerdo a su estado civil.
SELECT MaritalStatus, 
COUNT(H.BusinessEntityID) AS ESTADO_CIVIL 
from HumanResources.Employee H 
GROUP BY MaritalStatus ;
GO

--13. Ver cantidad de empleados por género
SELECT 
Gender, 
COUNT(H.BusinessEntityID) AS Genero 
from HumanResources.Employee H 
GROUP BY Gender ;
GO

--14. Ver listado de Departamentos
SELECT * from HumanResources.Department
GO

--15. Ver cantidad de empleados por cada departamento
SELECT DISTINCT Name,    
       COUNT(edh.BusinessEntityID) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept  
FROM HumanResources.EmployeePayHistory AS eph  
JOIN HumanResources.EmployeeDepartmentHistory AS edh  
     ON eph.BusinessEntityID = edh.BusinessEntityID  
JOIN HumanResources.Department AS d  
ON d.DepartmentID = edh.DepartmentID;
GO