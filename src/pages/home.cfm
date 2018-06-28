 <!--- CF logic --->
<cfparam name="userRegistered" default = 0>
<cfparam name="existingUser" default = 0>
<cfparam name="loginSuccess" default = 0>
<cfset regErrList = "">
<cfset loginErrList = "">
<cfset oLogin = createobject("component", "src.components.login") />
<cfset oRegistration = createobject("component", "src.components.registration") />
 
<cfif isDefined("btnRegister")>
    <cfset regErrList = oRegistration.getErrorList(form)>
    
    <cfif listLen(regErrList) eq 0>
        <cfset userRegistered = oRegistration.validateRegistration(form)>
        <cfif NOT userRegistered>
            <cfset existingUser = 1>
        </cfif>
    </cfif>
</cfif>

<cfif isDefined("btnLogin")>
    <cfset loginErrList = oLogin.getLoginErrors(form)>
    
    <cfif listLen(loginErrList) eq 0>
        <cfset session.user = "#form.loginUser#">
        <cflocation url="/src/pages/AddBlog.cfm">
    </cfif>
</cfif>

<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <style type="text/css">
            /* * {box-sizing: border-box} */
            /* body {font-family: "Lato", sans-serif;} */
        
            /* Style the tab */
            .tab {
                float: left;
                border: 1px solid #ccc;
                background-color: #f1f1f1;
                width: 30%;
                height: 300px;
            }
        
            /* Style the buttons inside the tab */
            .tab button {
                display: block;
                background-color: inherit;
                color: black;
                padding: 22px 16px;
                width: 100%;
                border: none;
                outline: none;
                text-align: left;
                cursor: pointer;
                transition: 0.3s;
                font-size: 17px;
            }
        
            /* Change background color of buttons on hover */
            .tab button:hover {
                background-color: #ddd;
            }
        
            /* Create an active/current "tab button" class */
            .tab button.active {
                background-color: #ccc;
            }
        
            /* Style the tab content */
            .tabcontent {
                padding: 0px 20px;
                border: 1px solid #ccc;
                width: 100%;
                border-left: none;
                height: 300px;
            }

            .error {
                color: red;
            }
            
            table#table-register {
                padding: 60px 220px;
                border-collapse: inherit;
            }

            table#table-login {
                padding: 60px 220px;
                border-collapse: inherit;
            }

            #table-register tr td .table-header,#table-login tr td .table-header {
                text-decoration: underline;
                font-weight: bold;
                padding: 2px;
            }
        
            </style>
</head>

<body>
    <div class="container">
        <div class="jumbotron" align="center">
            <h1 >Welcome to Blogspot by Contoso</h1>
            <p>Build your own custom, expressive blogs! <br>And the best part? It's free! </p>
        </div>
        
        
        <div class="tab">
            <button class="tablinks" onclick="openCity(event, 'registration-container')" id="defaultOpen">Register (new user)</button>
            <button class="tablinks" onclick="openCity(event, 'login-container')">Login (existing user)</button>
        </div>
        
        <div id="registration-container" class="tabcontent">
            <form name="registerUser" id="registerUser" action="/src/pages/home.cfm" method="post">
                <table id="table-register">
                    <tr><td style="text-decoration: underline; font-weight: bold; padding-bottom: 5px">Register a new user</td></tr>
                    <tr>
                        <td style="padding: 5px;">Registration email: </td>
                        <td style="padding: 5px;"><input type="text" id="userEmail" name="userEmail" /></td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;">Username: </td>
                        <td style="padding: 5px;"><input type="text" id="userName" name="userName" /></td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;">Password: </td>
                        <td style="padding: 5px;"><input type="password" id="userPwd" name="userPwd" /></td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;">Repeat password: </td>
                        <td style="padding: 5px;"><input type="password" id="rptPwd" name="rptPwd" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding: 5px;"><input type="submit" id="btnRegister" name="btnRegister" value="Register"/></td>
                    </tr>
                </table>
                
            </form>
        </div>
        
        <div id="login-container" class="tabcontent">
            <form name="loginForm" id="loginForm" action="/src/pages/home.cfm" method="post">
                <table id="table-login">
                    <tr><td style="text-decoration: underline; font-weight: bold; padding-bottom: 5px">Login</td></tr>
                    <tr>
                        <td style="padding: 5px;">Username: </td>
                        <td style="padding: 5px;"><input type="text" id="loginUser" name="loginUser" /></td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;">Password: </td>
                        <td style="padding: 5px;"><input type="password" id="loginPwd" name="loginPwd" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding: 5px;"><input type="submit" id="btnLogin" name="btnLogin" value="Login"/></td>
                    </tr>
                </table>
            </form>
        </div>

        <div>
            <cfif listLen(regErrList) neq 0>
                <ul>
                    <cfloop list="#regErrList#" index="error">
                        <cfoutput>
                            <li class="error">#error#</li>
                        </cfoutput>
                    </cfloop>
                </ul>
            </cfif>

            <cfif userRegistered eq 1>
                <span>User registered successfully!</span>
            </cfif>
            <cfif existingUser eq 1>
                <span>This user already exists. Please proceed to login.</span>
            </cfif>

            <cfif listLen(loginErrList) neq 0>
                <ul>
                    <cfloop list="#loginErrList#" index="error">
                        <cfoutput>
                            <li class="error">#error#</li>
                        </cfoutput>
                    </cfloop>
                </ul>
            </cfif>

        </div>
    </div>

    
    <script type="text/javascript">
        function openCity(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
        }
        
        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpen").click();
    </script>
</body>
</html>