var app = angular.module("application", ["ngRoute"]);

/*routing*/
app.config(function($routeProvider) {
    $routeProvider
    .when("/", {
        templateUrl : "start.html",
        controller  : "ctrlStart"
    })
    .when("/logowanie", {
        templateUrl : "log.html",
        controller  : "ctrlLog"
    })
    .when("/wylogowanie", {
        template : "<div class='col-sm-12 text-center alert alert-info'><strong>Wylogowano!</strong> Zostaniesz przekierowany za {{timeOff}}s.</div>",
        controller  : "ctrlOff"
    })
    .when("/rejestracja", {
        templateUrl : "reg.html",
        controller  : "ctrlReg"
    })
    .when("/edycja", {
        templateUrl : "edit.html",
        controller  : "ctrlEdit"
    })
    .when("/lista", {
        templateUrl : "lista.html",
        controller  : "ctrlList"
    })
    .when("/powitanie", {
        templateUrl : "tekst.html",
        controller  : "ctrlText"
    })
    .otherwise({
        template : "<div class='col-sm-12 text-center alert alert-warning'><strong>404!</strong> Nie ma takiej strony. Zostaniesz przekierowany za {{timeOff}}s.</div>",
        controller  : "notFound"
    });
});

/*ctrlMenu*/
app.controller('ctrlMenu', [ '$window', '$scope', '$location', function($window, $scope, $location){
    if ($window.localStorage.userId) { 
        $scope.userId = $window.localStorage.userId; 
        $scope.userLogin = $window.localStorage.userLogin; 
    }else{ 
        $scope.userId=false; 
    }
    if ($window.localStorage.userLogin!='admin') { 
        $('a[href="#lista"], a[href="#powitanie"]').parent().hide();
    }
}]);

/*ctrlStart*/
app.controller('ctrlStart', [ '$http', '$scope', '$sce', function($http, $scope, $sce){
    $http.get('api.php/ng_text/id/1/').success(function(response) {
        response = response[0];
        $scope.startText = $sce.trustAsHtml(response.text);
    });
}]);

/*ctrlLog*/
app.controller('ctrlLog', [ '$http', '$window', '$scope', '$location', function($http, $window, $scope, $location){
    if ($window.localStorage.userLogin) { $location.path('/'); }
    $scope.zaloguj = function(){
        $http.get('api.php/ng_users/login/'+$scope.login+'/password/'+$scope.password).success(function(response) {
            response = response[0];
            if(response.id){
                $window.localStorage.userLogin=response.login;
                $window.localStorage.userId=response.id;
                $location.path('/'); 
            }else{
                $scope.loginIncorrect = true;
            }
        });
    }
}]);

/*ctrlOff*/
app.controller('ctrlOff', [ '$window', '$interval', '$scope', '$location', function($window, $interval, $scope, $location){
    $window.localStorage.userId="";
    $window.localStorage.userLogin="";
    $scope.timeOff=3;
    $interval(function(){
        $scope.timeOff--;
        if ($scope.timeOff==0) { $location.path('/'); }
    }, 1000);
}]);

/*ctrlReg*/
app.controller('ctrlReg', [ '$http', '$window', '$scope', '$location', function($http, $window, $scope, $location){
    if ($window.localStorage.userLogin) { $location.path('/'); }
    $scope.regexLogin = /^[a-zA-Z0-9]{5,}$/;

    $scope.rejestruj = function(){
        var config={
            login   : $scope.login, 
            password: $scope.password, 
            email   : $scope.email
        };
        $http.post('api.php/ng_users', config).success(function(response) {
            if(response){
                $scope.rejestrujInfo = "Zarejestrowano.";
                $scope.rejestrujInfoColor = "success";
            }else{
                $scope.rejestrujInfo = "Nie można zarejestrować tej nazwy użytkownika. Prawdopodobnie już istnieje.";
                $scope.rejestrujInfoColor = "warning";
            }
        });
    }
}]);

/*ctrlEdit*/
app.controller('ctrlEdit', [ '$http', '$window', '$scope', function($http, $window, $scope){
    $scope.regexLogin = /^[a-zA-Z0-9]{5,}$/;
    $scope.regexWww = /^(http|https):\/\/[a-zA-Z0-9-.]+[\.]{1}[a-zA-Z]{2,4}$/;
    $scope.userId = $window.localStorage.userId;
    
    $http.get('api.php/ng_users/id/'+$scope.userId).success(function(response) {
        $scope.user = response[0];
        $scope.user.birth = new Date($scope.user.birth);
    });

    $scope.zapiszZmiany = function(){
        var config = $scope.user;
        $http.put('api.php/ng_users', config).success(function(response) {
            if(response){
                $scope.zapiszZmianyInfo = "Aktualizacja powiodła się.";
                $scope.zapiszZmianyInfoColor = "success";
            }else{
                $scope.zapiszZmianyInfo = "Aktualizacja nie powiodła się.";
                $scope.zapiszZmianyInfoColor = "warning";
            }
        });
    }
}]);

/*ctrlText*/
app.controller('ctrlText', [ '$http', '$window', '$scope', '$location', function($http, $window, $scope, $location){
    if ($window.localStorage.userLogin!='admin') { $location.path('/'); }
    $http.get('api.php/ng_text/id/1').success(function(response) {
        $scope.start = response[0];
        $('#editor').html(response[0].text);
    });
    $scope.zapiszTekstInfoColor = "default";

    $scope.zapiszTekst = function(){
        $scope.start.id = 1;
        $scope.start.text = $('#editor').html();
        $http.put('api.php/ng_text', $scope.start).success(function(response) {
            if(response){
                $scope.zapiszTekstInfoColor = "success";
            }else{
                $scope.zapiszTekstInfoColor = "warning";
            }
        });
    }
    //editor   //$('#editor').cleanHtml();
    $('#editor').wysiwyg(); 
}]);

/*notFound*/
app.controller('notFound', [ '$interval', '$scope', '$location', function($interval, $scope, $location){
    $scope.timeOff=3;
    $interval(function(){
        $scope.timeOff--;
        if ($scope.timeOff==0) { $location.path('/'); }
    }, 1000);
}]);









































/*ctrlList*/
app.controller('ctrlList', [ '$http', '$window', '$scope', '$location', function($http, $window, $scope, $location){
    if ($window.localStorage.userLogin!='admin') { $location.path('/'); }
    $scope.downloadColor = "default";
    $scope.uploadColor = "default";

    $http.get('api.php/ng_users').success(function(response) {
        $scope.listaKont = response;
    });

    $scope.download = function(){
        $http.get('api.php/ng_users').success(function(response) {
            $scope.listaKont = response;
            $scope.downloadColor = "success";
            $scope.uploadColor = "default";
        });
    }

    $scope.upload = function(){
        console.log("up");
        $scope.downloadColor = "default";
        $scope.uploadColor = "success";

        var config = $scope.user;
        $http.put('api.php/ng_users', config).success(function(response) {
            if(response){
                $scope.zapiszZmianyInfo = "Aktualizacja powiodła się.";
                $scope.zapiszZmianyInfoColor = "success";
            }else{
                $scope.zapiszZmianyInfo = "Aktualizacja nie powiodła się.";
                $scope.zapiszZmianyInfoColor = "warning";
            }
        });
    }

}]);