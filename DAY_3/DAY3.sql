-- ZIYAN YUAN HOMEWORK DAY3

use Northwind

-- problem1
Select DISTINCT e.city
From Employees e, Customers c
Where e.city = c.city

-- problem2, attribute come from customers expect employees
-- a
Select city
From Customers 
Where city NOT IN(
	SELECT city
	From Employees
)
-- b
Select a.city
From Customers a
LEFT JOIN Employees b On a.city = b.city
WHERE b.city IS Null

-- problem3
Select ProductID, count(productID) [total order]
From [Order Details]
Group By productId

-- problem4
Select c.City, ood.[total product]
From Customers c, (Select o.customerID, count(o.CustomerID) [total product]
From [Order Details] od, Orders o
Where od.Orderid = o.OrderID
Group By o.CustomerID) ood
Where c.CustomerID = ood.CustomerID
ORDER BY c.City

-- problem5
-- a£¨£©

-- b
Select DISTINCT c1.City
From Customers c1, (Select City, count(CustomerId) numofProducts
From Customers
Group By City ) c2
Where c1.city = c2.city AND c2.numofProducts >= 2

-- problem6
Select c.City
From Customers c Join Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
Group By c.City
HAVING count(ProductID) >= 2

-- problem7
Select DISTINCT c.CompanyName
From Customers c RIGHT Join Orders o 
ON c.city != o.shipcity

-- problem8
Select TOP 5 p.ProductName, AVG(od.UnitPrice) AS [Avgerage Price], (
	Select TOP 1 c.City 
	From Customers c 
	INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
	INNER JOIN [Order Details] od2 ON o.OrderID = od2.OrderID 
	WHERE od2.ProductID = p.ProductID 
	Group By c.City 
	Order By SUM(od2.Quantity) DESC) AS City, 
SUM(od.Quantity) AS TotalQuantity
From Products p 
    JOIN [Order Details] od ON p.ProductID = od.ProductID 
    JOIN Orders o ON od.OrderID = o.OrderID 
    JOIN Customers c ON o.CustomerID = c.CustomerID
Group By p.ProductID, p.ProductName
Order By TotalQuantity DESC

-- problem9
-- a
Select DISTINCT City
From Employees
Where City NOT IN (
Select DISTINCT City 
From Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID)

-- b
Select DISTINCT e.City
From Employees e
LEFT JOIN Customers c ON e.City = c.City
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
Where c.City IS NULL AND o.CustomerID IS NULL

-- problem10
SELECT e.City AS EmployeeCity, c.City AS CustomerCity, COUNT(DISTINCT o.OrderID) AS TotalOrders, SUM(od.Quantity) AS TotalQuantity
FROM Employees e
     JOIN Orders o ON e.EmployeeID = o.EmployeeID
     JOIN Customers c ON o.CustomerID = c.CustomerID 
	 JOIN [Order Details] od ON o.OrderID = od.OrderID
	 JOIN ( SELECT EmployeeID, COUNT(DISTINCT OrderID) AS OrderCount 
        FROM Orders 
        GROUP BY EmployeeID -- count the number of every employees' order
        ) AS oc ON e.EmployeeID = oc.EmployeeID 
	 JOIN ( SELECT City, SUM(Quantity) AS TotalQuantity 
        FROM [Order Details] od 
            JOIN Orders o ON od.OrderID = o.OrderID 
            JOIN Customers c ON o.CustomerID = c.CustomerID 
        GROUP BY 
            City -- count the number of every city's products
        ) AS tq ON c.City = tq.City 
GROUP BY e.City, c.City
HAVING COUNT(DISTINCT o.OrderID) = ( SELECT MAX(OrderCount) 
        FROM (SELECT EmployeeID, COUNT(DISTINCT OrderID) AS OrderCount 
            FROM Orders 
            GROUP BY EmployeeID) a)
    OR SUM(od.Quantity) = (SELECT MAX(TotalQuantity) 
        FROM ( SELECT City, SUM(Quantity) AS TotalQuantity 
            FROM [Order Details] od 
				JOIN Orders o ON od.OrderID = o.OrderID 
                JOIN Customers c ON o.CustomerID = c.CustomerID 
            GROUP BY City) b)	

-- problem11 example£º
Delete From Customers 
Where CustomerID NOT IN 
(Select MIN(CustomerID) 
 From Customers 
 Group By ContactName, City, Country);

 -- Assume this table has 4 attributes: CustomerID, CustomerName, City, Country. The CustomersID is the primary Key.
 -- group by attributes besides primary key and check if it is same or not. For the same group, they are duplicated.
 -- Then detele the duplicated from the table.


