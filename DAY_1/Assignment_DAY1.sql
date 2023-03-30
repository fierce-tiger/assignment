-- Ziyan Yuan
-- Day1

USE AdventureWorks2019
-- question1
Select ProductID, Name, Color, ListPrice
From Production.Product;

-- question2
Select ProductID, Name, Color, ListPrice
From Production.Product
Where ListPrice != 0;

-- question3
Select ProductID, Name, Color, ListPrice
From Production.Product
Where Color is Null;

-- question4
Select ProductID, Name, Color, ListPrice
From Production.Product
Where Color is not Null;

-- question5
Select ProductID, Name, Color, ListPrice
From Production.Product
Where Color is not Null AND ListPrice > 0;

-- question6
Select Name + Color 
From Production.Product
Where Color is not Null;

-- question7
Select 'NAME: ' + NAME + ' -- ' + 'Color: ' + Color AS [Name And Color]
From Production.Product
Where NAME is not Null and Color is not Null;

-- question8
Select ProductID, Name
From Production.Product
Where ProductID Between 400 AND 500;

-- question9
Select ProductID, Name, Color
From Production.Product
Where Color = 'black' or Color = 'blue';

Select Name -- result sets of Name
From Production.Product
Where Name like 's%';

-- question11
Select Name, ListPrice
From Production.Product
Order By Name;

-- question12
Select Name, ListPrice
From Production.Product
Where Name like 'A%' or Name like 'S%'
Order By Name;

-- question13
Select Name 
From Production.Product
Where Name like 'SPO%' AND Name not like 'SPOK%';

-- question14
Select DISTINCT Color
From Production.Product
Order BY Color DESC;

-- question15 (assume that it is ascending)
Select DISTINCT ProductSubcategoryID, Color
From Production.Product
Where ProductSubcategoryID is not Null AND Color is not Null;