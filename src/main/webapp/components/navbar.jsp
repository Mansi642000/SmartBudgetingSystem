
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<nav class="navbar navbar-dark" style="background-color:green">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Smart Budgeting System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                
                <li class="nav-item">
                    <a class="nav-link active"
                       href="<c:choose>
                                <c:when test='${not empty sessionScope.user}'>dashboard.jsp</c:when>
                                <c:otherwise>index.jsp</c:otherwise>
                             </c:choose>">
                        <i class="fa-solid fa-house"></i> Dashboard
                    </a>
                </li>

                <!-- If user is logged in -->
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <i class="fa-solid fa-user"></i>
                            Welcome, ${sessionScope.user.name}
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<%= request.getContextPath() %>/logout.jsp">
                            <i class="fa-solid fa-right-from-bracket"></i> Logout
                        </a>
                    </li>
                </c:if>

                <!-- If user is not logged in -->
                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link active" href="login.jsp">
                            <i class="fa-solid fa-right-to-bracket"></i> Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="register.jsp">
                            <i class="fa-solid fa-user-plus"></i> Register
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
