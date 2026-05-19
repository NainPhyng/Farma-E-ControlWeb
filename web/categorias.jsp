<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%

String cat = request.getParameter("cat");
String sub = request.getParameter("sub");
String item = request.getParameter("item");

if (cat == null) cat = "";
if (sub == null) sub = "";
if (item == null) item = "";

java.util.Map<String, String> nombres = new java.util.HashMap<>();

nombres.put("medicamentos", "Medicamentos");
nombres.put("equipo", "Equipo y Botiquín");
nombres.put("vitaminas", "Vitaminas y Suplementos");
nombres.put("dermocosmeticos", "Dermocosméticos");
nombres.put("cuidado", "Cuidado Personal y Belleza");
nombres.put("bebes", "Bebés");
nombres.put("alimentos", "Alimentos y Bebidas");
nombres.put("salud", "Salud sexual");

nombres.put("analgesicos", "Analgésicos");
nombres.put("antibioticos", "Antibióticos");

nombres.put("antibioticos_orales", "Antibióticos Orales");
nombres.put("antibioticos_topicos", "Antibióticos tópicos");
nombres.put("ibuprofeno", "Ibuprofeno");

String titulo = "";

if (!item.isEmpty())
    titulo = nombres.get(item);
else if (!sub.isEmpty())
    titulo = nombres.get(sub);
else if (!cat.isEmpty())
    titulo = nombres.get(cat);
else
    titulo = "Productos";

%>

<!DOCTYPE html>
<html lang="es">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title><%= titulo %> | Farma E-Control</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/diseño.css">

<style>

.sidebar {
    width: 260px;
}

.product-card {
    transition: 0.3s;
}

.product-card:hover {
    transform: scale(1.03);
}

.price {
    font-size: 1.2rem;
    font-weight: bold;
}

</style>

</head>

<body>

<div class="header">

    <a href="index.html" class="logo">

        <img src="img/logo.png"
             alt="Farma E-Control"
             style="width: 60px; height: 60px;">

        <div>
            <div>FARMA</div>
            <div style="font-size:10px;">E-CONTROL</div>
        </div>

    </a>

    <div class="search-container">
        <input type="text"
               class="search-box"
               placeholder="🔍">
    </div>

</div>

<div class="nav">

    <div class="menu-categorias">

        <button class="cat-btn">
            CATEGORÍAS ▼
        </button>

    </div>

    <div class="ofertas">
        <button class="ofe-btn">
            OFERTAS
        </button>
    </div>

</div>

<div class="container-fluid my-4">

<div class="row">

<aside class="col-md-3 sidebar border-end">

<h5><strong>Filtros</strong></h5>

<hr>

<h6 class="fw-bold">Precio</h6>

<ul class="list-unstyled">

<li><input type="checkbox"> $0 - $99</li>
<li><input type="checkbox"> $100 - $199</li>
<li><input type="checkbox"> $200 - $499</li>
<li><input type="checkbox"> $500 - $999</li>
<li><input type="checkbox"> $1000 o más</li>

</ul>

<hr>

</aside>

<main class="col-md-9">

<h3 class="fw-bold mb-3">
    <%= titulo %>
</h3>

<div class="row g-3">

<%

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farma?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
    );

    String sql = "SELECT * FROM productos WHERE 1=1";

    if (!cat.isEmpty())
        sql += " AND categoria=?";

    if (!sub.isEmpty())
        sql += " AND subcategoria=?";

    if (!item.isEmpty())
        sql += " AND item=?";

    ps = conn.prepareStatement(sql);

    int i = 1;

    if (!cat.isEmpty())
        ps.setString(i++, cat);

    if (!sub.isEmpty())
        ps.setString(i++, sub);

    if (!item.isEmpty())
        ps.setString(i++, item);

    rs = ps.executeQuery();

    boolean hay = false;

    while (rs.next()) {

        hay = true;

%>

<div class="col-md-4">

<div class="card product-card p-2 shadow-sm">

<img src="<%= rs.getString("imagen") %>"
     class="card-img-top"
     alt="Producto">

<div class="card-body">

<h6 class="card-title">
    <%= rs.getString("nombre") %>
</h6>

<p class="price text-primary">
    $<%= rs.getDouble("precio") %>
</p>

<button
class="btn btn-primary w-100"
onclick="agregarAlCarrito(
'<%= rs.getString("nombre") %>',
<%= rs.getDouble("precio") %>
)">
Agregar al carrito
</button>

</div>
</div>
</div>

<%

}

if (!hay) {

%>

<p class="text-muted">
No hay productos disponibles.
</p>

<%

}

} catch(Exception e) {

out.println("<p style='color:red;'>Error: "
+ e.getMessage() +
"</p>");

} finally {

try {
    if(rs != null) rs.close();
} catch(Exception e){}

try {
    if(ps != null) ps.close();
} catch(Exception e){}

try {
    if(conn != null) conn.close();
} catch(Exception e){}

}

%>

</div>

<nav class="mt-4">

<ul class="pagination">

<li class="page-item disabled">
<a class="page-link">Anterior</a>
</li>

<li class="page-item active">
<a class="page-link">1</a>
</li>

<li class="page-item">
<a class="page-link">2</a>
</li>

<li class="page-item">
<a class="page-link">3</a>
</li>

<li class="page-item">
<a class="page-link">Siguiente</a>
</li>

</ul>

</nav>

</main>
</div>
</div>

<script>

function agregarAlCarrito(nombre, precio){

    let carrito =
    JSON.parse(localStorage.getItem("carrito")) || [];

    let producto =
    carrito.find(p => p.nombre === nombre);

    if(producto){

        producto.cantidad++;

    }else{

        carrito.push({

            nombre: nombre,
            precio: precio,
            cantidad: 1

        });

    }

    localStorage.setItem(
        "carrito",
        JSON.stringify(carrito)
    );

    alert("Producto agregado al carrito");

}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>