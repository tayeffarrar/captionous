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
	console.log('worked!')
		e.preventDefault();

		values = {
			keyword: $('#search-picture-keyword').value
		}

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