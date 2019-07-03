#!/usr/bin/env node

var express = require("express")
var bodyParser = require("body-parser")
var app = express()

app.use(bodyParser.urlencoded({extended:true}))

// use bodyParser-json
app.use(bodyParser.json())

//use bodyParser-text
app.use(bodyParser.text({type:"txt"}))

// you http reques path
app.post('/deploy', function(req, res) {
	var
  	hmac,
  	calculatedSignature,
  	payload = req.body;
	var crypto = require('crypto');
	//your github  webhook secret code
	var secret = '5CEC4A2936ABAA2828B0811F48B2C6EAD703F763490E05840B571374C977BC87';
	hmac = crypto.createHmac('sha1', secret);
	hmac.update(JSON.stringify(payload));
	calculatedSignature = 'sha1=' + hmac.digest('hex');

	if (req.headers['x-hub-signature'] === calculatedSignature) {
  		console.log('all good');
	} else {
	  	console.log('not good');
                res.statusCode = 500;
                res.setHeader('Content-Type', 'text/plain');
                res.end('Signature err!');
		return ;
	}
	//console.log(req.body)
	const { exec } = require('child_process');
	var command = 'your need run command write here';
	exec(command, (err, stdout, stderr) => {
  	    if (err) {
  	    	console.log(`stderr: ${stderr}`);
            	res.statusCode = 500;
            	res.setHeader('Content-Type', 'text/plain');
            	res.end('Deploy  Failed!');
    	    	return;
 	    }
  	    console.log(`stdout: ${stdout}`);
	    res.statusCode = 200;
  	    res.setHeader('Content-Type', 'text/plain');
  	    res.end('Deploy OK!');
	});
});

var server = app.listen(3000, function(){
	console.log("App listening at 3000...")
});
