<?php
try{
	$method = $_SERVER['REQUEST_METHOD'];
	$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
	$input = json_decode(file_get_contents('php://input'),true);
	$table = preg_replace('/[^a-z0-9_]+/i','',array_shift($request));

	include('connect.php');
	$connect = new PDO('mysql:host='.$host.';dbname='.$base.';charset=utf8', $user, $pass);
	




	/***GET*** Wyszukuje w tabeli po kryteriach
	$http.get('api.php/ng_text/id/1').success(function(response) {
	    console.log(response);
	});
	*********/
	if($method=="GET"){
		$requests = array();
		foreach ($request as $key => $value) {
			 if($key%2==0) { $requests[$value] = $request[$key+1]; }
		}
		$where = "";
		if(count($requests)){
			$where = "WHERE ";
			foreach ($requests as $key => $value) {
				if($key == "password"){ $value = md5($value); }
				$where .= $key."='".$value."' AND ";
			}
			$where = substr($where, 0, strripos($where, ' AND '));
		}

	$sql = "select * from `$table` $where";
	$query = $connect->query($sql);
	$result = $query->fetchAll(PDO::FETCH_ASSOC);
	//delete passwords
	$delPass = array();
	foreach ($result as $key => $value) {
		if($value['password']){ array_push($delPass, $key);	}
	}
	foreach ($delPass as $v) {
		unset($result[$v]['password']);
	}
	$return = json_encode($result);
	}





	/***POST*** Dodaje do tabeli rekord
	var config={ 
		login   : $scope.login, 
		password: $scope.password, 
		email   : $scope.email  
	};
    $http.post('api.php/ng_users', config).success(function(response) {
        console.log(response);
    });
	*********/
	if($method=="POST"){
		foreach ($input as $key => $value) {
			$inputs .= "`".$key."`,";
			$values .= ($key=="password") ? "'".md5($value)."'," : "'".$value."'," ;
		}
		$inputs = substr($inputs, 0, -1);
		$values = substr($values, 0, -1);

	$sql = "insert into `$table` ($inputs) values ($values)"; 
	$return = $connect->exec($sql);
	}






	/***PUT*** Aktualizacja tabel
    var config = {
        user: $scope.user
	}
    $http.put('api.php/ng_users', config).success(function(response) {
   	    console.log(response);
    });
	*********/
	if($method=="PUT"){
		foreach ($input as $key => $value) {
			$sets .= "`".$key."` = '".$value."',";
			//$values .= ($key=="password") ? "'".md5($value)."'," : "'".$value."'," ;
		}
		$id = $input['id'];
		$sets = substr($sets, 0, -1);

	$sql = "update `$table` set $sets where `id` = $id"; 
	$return = $connect->exec($sql);
	}

	echo $return;
	$connect = null;
}catch(PDOException $err){}
?>