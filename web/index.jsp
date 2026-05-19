<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%
    // 1. Revisamos si hay un usuario (cliente) firmado en la sesión
    Object usuarioLogueado = session.getAttribute("usuario"); 
    
    // 2. Si no existe un carrito temporal en la sesión, se lo creamos vacío
    if (session.getAttribute("carrito") == null) {
        session.setAttribute("carrito", new ArrayList<Integer>());
    }
    
    // Recuperamos el tamaño actual del carrito para mostrarlo en el icono
    ArrayList<Integer> carritoActual = (ArrayList<Integer>) session.getAttribute("carrito");
    int conteoProductos = (carritoActual != null) ? carritoActual.size() : 0;
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Farma E-Control</title>
        <link rel="stylesheet" href="css/diseño.css">
    </head>
    <body>
        <div class="header">
            <a href="index.jsp" class="logo">
                <img src="img/logo.png" alt="Farma E-Control" style="width: 60px; height: 60px;">
                <div>
                    <div>FARMA</div>
                    <div style="font-size: 10px;">E-CONTROL</div>
                </div>
            </a>

            <div class="search-container">
                <input type="text" class="search-box" placeholder="🔍">
            </div>

            <div class="header-icons">
                <a href="sucursales.jsp" class="icon-item">
                    <img src="img/sucursales.png" alt="Sucursales">
                    Sucursales
                </a>
                
                <% if (usuarioLogueado == null) { %>
                    <a href="login.jsp" class="icon-item">
                        <img src="img/micuenta.png" alt="Iniciar Sesión">
                        Iniciar Sesión
                    </a>
                <% } else { %>
                    <a href="miCuenta.jsp" class="icon-item">
                        <img src="img/micuenta.png" alt="Mi cuenta">
                        Mi cuenta
                    </a>
                    <a href="CerrarSesionServlet" class="icon-item" style="color: #ff4d4d; font-weight: bold;">
                        Salir
                    </a>
                <% } %>
                
                <a href="carrito.jsp" class="icon-item">
                    <img src="img/carrito.png" alt="Mi carrito">
                    Mi carrito <span style="color: #00bcd4; font-weight: bold;">(<%= conteoProductos %>)</span>
                </a>
                <a href="facturas.html" class="icon-item">
                    <img src="img/facturas.png" alt="Facturas">
                    Facturas
                </a>
                <a href="membresias.html" class="icon-item">
                    <img src="img/membresias.png" alt="Membresías">
                    Membresías
                </a>
            </div>
        </div>

        <div class="nav">
            <div class="menu-categorias" style="position:center;">
                <button class="cat-btn" onclick="toggleMenu()">Categorías ▼</button>

                <div id="menu-azul" class="menu-azul" aria-expanded="false">
                    <div class="cat-item" onclick="mostrarSubmenu('medicamentos')">Medicamentos <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('equipo')">Equipo y botiquín <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('vitaminas')">Vitaminas y suplementos <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('dermocosmeticos')">Dermocosméticos <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('cuidado')">Cuidado personal y belleza <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('bebes')">Bebés <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('alimentos')">Alimentos y bebidas <span class="arrow">▶</span></div>
                    <div class="cat-item" onclick="mostrarSubmenu('salud')">Salud sexual <span class="arrow">▶</span></div>
                </div>

                <div id="submenu" class="submenu-panel" aria-hidden="true"></div>
            </div>
            
            <div class="ofertas">
                <a href="ofertas.html" class="ofe-btn">OFERTAS</a>
            </div>

            <div class="articulos" style="position:center;">
                <a class="ofe-btn" href="articulos.html">ARTICULOS</a>
            </div>
        </div>

        <div class="banner">
            <div class="carousel">
                <div class="carousel-item"><img src="img/banner1.png" alt="Banner 1" style="max-width: 100%; height: auto;"></div>
                <div class="carousel-item"><img src="img/banner2.jpg" alt="Banner 2" style="max-width: 100%; height: auto;"></div>
                <div class="carousel-item"><img src="img/banner3.png" alt="Banner 3" style="max-width: 100%; height: auto;"></div>
                <div class="carousel-item"><img src="img/banner4.jpg" alt="Banner 4" style="max-width: 100%; height: auto;"></div>
            </div>
            <div class="carousel-controls">
                <button class="carousel-btn" onclick="prevSlide()">❮</button>
                <button class="carousel-btn" onclick="nextSlide()">❯</button>
            </div>
        </div>

        <div class="filter-buttons">
            <div class="filter-header">+ Bien</div>
            <div class="filter-options">
                <a href="ranking.jsp?tipo=usados" class="filter-option">+ usados</a>
                <a href="ranking.jsp?tipo=vendidos" class="filter-option">+ vendido</a>
                <a href="ranking.jsp?tipo=buscados" class="filter-option">+ buscados</a>
            </div>
        </div>

        <div class="categories">
            <div class="category-item">
                <div class="category-circle cat-blue"><img src="img/cuidado.png" alt="Cuidado" class="category-image"></div>
                <div>Cuidado Personal</div>
            </div>
            <div class="category-item">
                <div class="category-circle cat-pink"><img src="img/cosmeticos.png" alt="Dermocosméticos" class="category-image"></div>
                <div>Dermocosmeticos</div>
            </div>
            <div class="category-item">
                <div class="category-circle cat-green"><img src="img/maternidad.png" alt="Bebes" class="category-image"></div>
                <div>Bebes y maternidad</div>
            </div>
            <div class="category-item">
                <div class="category-circle cat-orange"><img src="img/nutricion.png" alt="Nutricion" class="category-image"></div>
                <div>Nutricion y suplementos</div>
            </div>
        </div>

        <div class="recommendations">
            <h2>⚙️ Recomendaciones de la semana ⚙️</h2>
            <div class="products-grid">
                <div class="product-card">
                    <div class="product-image"><img src="img/MI-Prim.png" alt="Mi-Prim 24 cápsulas"></div>
                    <div class="product-name">Mi-Prim 24 cápsulas</div>
                    <span class="product-badge">Exclusivo en línea</span>
                    <div style="color: #999; font-size: 12px;">20% de descuento</div>
                    <div class="product-price">$115.60</div>
                    <div style="font-size: 12px; color: #666; margin-bottom: 10px;">Envío GRATIS</div>
                    <form action="AgregarCarritoServlet" method="POST">
                        <input type="hidden" name="id_medicamento" value="1"> 
                        <button type="submit" class="add-to-cart">Agregar al carrito</button>
                    </form>
                </div>

                <div class="product-card">
                    <div class="product-image"><img src="img/ArianaGrande.png" alt="Perfume Ariana Grande Sweet Like Candy"></div>
                    <div class="product-name">Perfume Ariana Grande Sweet Like Candy Eau de Pa...</div>
                    <span class="product-badge">Exclusivo en línea</span>
                    <div style="color: #999; font-size: 12px;">15% de descuento</div>
                    <div class="product-price">$799.00</div>
                    <div style="font-size: 12px; color: #666; margin-bottom: 10px;">Envío GRATIS</div>
                    <form action="AgregarCarritoServlet" method="POST">
                        <input type="hidden" name="id_medicamento" value="2"> 
                        <button type="submit" class="add-to-cart">Agregar al carrito</button>
                    </form>
                </div>

                <div class="product-card">
                    <div class="product-image"><img class="vertical" src="img/suero.png" alt="The Ordinary Salicylic Acid 2% Solution"></div>
                    <div class="product-name">The Ordinary Salicylic Acid 2% Solution</div>
                    <span class="product-badge">Exclusivo en línea</span>
                    <div class="product-price">$165.00</div>
                    <div style="font-size: 12px; color: #666; margin-bottom: 10px;">Envío GRATIS</div>
                    <form action="AgregarCarritoServlet" method="POST">
                        <input type="hidden" name="id_medicamento" value="3"> 
                        <button type="submit" class="add-to-cart">Agregar al carrito</button>
                    </form>
                </div>

                <div class="product-card">
                    <div class="product-image"><img src="img/nebulizador.png" alt="Omron Nebulizador de Compresor Ne-C101"></div>
                    <div class="product-name">Omron Nebulizador de Compresor Ne-C101</div>
                    <div style="color: #999; font-size: 12px;">40% de descuento</div>
                    <div class="product-price">$902.40</div>
                    <div style="font-size: 12px; color: #666; margin-bottom: 10px;">Envío GRATIS</div>
                    <form action="AgregarCarritoServlet" method="POST">
                        <input type="hidden" name="id_medicamento" value="4"> 
                        <button type="submit" class="add-to-cart">Agregar al carrito</button>
                    </form>
                </div>

                <div class="product-card">
                    <div class="product-image"><img class="vertical" src="img/proteina.png" alt="Falcon Performance Proteina Vegetal Sabor Choco"></div>
                    <div class="product-name">Falcon Performance Proteina Vegetal Sabor Choco...</div>
                    <span class="product-badge">Exclusivo en línea</span>
                    <div style="color: #999; font-size: 12px;">40% de descuento</div>
                    <div class="product-price">$1,064.00</div>
                    <div style="font-size: 12px; color: #666; margin-bottom: 10px;">Envío GRATIS</div>
                    <form action="AgregarCarritoServlet" method="POST">
                        <input type="hidden" name="id_medicamento" value="5"> 
                        <button type="submit" class="add-to-cart">Agregar al carrito</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="blog-section">
            <h2>Vlog de Farma E-Control con artículos para tu Salud y Bienestar</h2>
            <div class="blog-grid">
                <div class="blog-card">
                    <div class="blog-image"><img src="img/rutinaSueno.png" alt="Rutina de sueño"></div>
                    <div class="blog-title">¿Cómo crear una buena rutina del sueño para ti?</div>
                    <p class="blog-extract">Aprende a crear un hábito de descanso realmente saludable.</p>
                    <a href="sueño.html" class="blog-link">Leer más....</a>
                </div>
                <div class="blog-card">
                    <div class="blog-image"><img src="img/sistemainmune.png" alt="Sistema Inmune"></div>
                    <div class="blog-title">¿Cómo reforzar tu sistema inmune por el cambio de temperaturas?</div>
                    <p class="blog-extract">Consejos prácticos para fortalecer tus defensas.</p>
                    <a href="inmune.html" class="blog-link">Leer más....</a>
                </div>
                <div class="blog-card">
                    <div class="blog-image"><img src="img/saludmental.png" alt="Salud Mental"></div>
                    <div class="blog-title">¿Cómo cuidar la salud mental? estrategias según la edad?</div>
                    <p class="blog-extract">Guía clara y útil para cada etapa de la vida.</p>
                    <a href="saludmental.html" class="blog-link">Leer más....</a>
                </div>
            </div> 
        </div> 

        <script>
            let currentSlide = 0;
            const slides = document.querySelectorAll('.carousel-item');
            function showSlide(n) {
                if (n >= slides.length) currentSlide = 0;
                if (n < 0) currentSlide = slides.length - 1;
                const carousel = document.querySelector('.carousel');
                carousel.style.transform = `translateX(-${currentSlide * 100}%)`;
            }
            function nextSlide() { currentSlide++; showSlide(currentSlide); }
            function prevSlide() { currentSlide--; showSlide(currentSlide); }
            setInterval(nextSlide, 5000);
            
            function toggleMenu() {
                const menu = document.getElementById("menu-azul");
                menu.style.display = menu.style.display === "block" ? "none" : "block";
            }
        </script>
    </body>
</html>