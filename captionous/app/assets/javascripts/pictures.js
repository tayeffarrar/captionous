console.log("everything is ok at pictures.js");

var keyword;

$(function(){
	$.ajax({
		url: '/pictures',
		method: 'GET',
		dataType: 'json',
		success: function(data){ 
			data.forEach(function(pictures){
				renderPicture(picture);
			})
		}
	})

	$('#search').on('submit', function(e){
		e.preventDefault();
		
		values = {

		keyword: document.getElementById("search-picture-keyword").value
	}

	console.log('this worked!')

		$(this).children('input').not('input[type=submit]').val('');

		$.ajax({
			url: '/pictures',
			method: 'POST',
			data: values,
			dataType: 'json',
			success: function(picture){
				renderPicture(picture);
			}
		})
	})
})