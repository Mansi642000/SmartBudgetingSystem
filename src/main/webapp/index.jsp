<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/htm">
<title>Home Page</title>
 <%@include file="components/all_css_js.jsp"%>
<style>
	.carousel-inner {
    background-color: darkgreen;
	}
	.carousel-item img {
    height: 100vh; /* Full screen height */
    width: 100%;
    object-fit: cover; /* Keeps image ratio and covers the area */
  }
	.footer {
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  background-color: green;
  color: white;
  text-align: center;
}
</style>
</head>
<body>
 	<%@include file="components/navbar.jsp"%>
 	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="images/bg1.png" class="d-block w-100" alt="..." height="650px">
    </div>
    <div class="carousel-item">
      <img src="images/bg2.png" class="d-block w-100" alt="..." height="650px">
    </div>
    <div class="carousel-item">
      <img src="images/bg3.png" class="d-block w-100" alt="..." height="650px">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
 <div class="footer">
  <p> &copy Smart Budgeting System , 2025</p>
</div>

</body>
</html>