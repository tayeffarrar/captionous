console.log("everything is ok at pictures.js");

$(function(){
	$.ajax({
		url: '/pictures',
		method: 'GET',
		data: @testtag,
		dataType: 'json',
		success: function(data){
			data.forEach(function(pictures){
				renderPicture(picture);
			})
		}
	})
	$('#search-picture-keyword').on('submit', function(e){
		e.preventDefault();

		values = {
			keyword:
				$('#search-picture-keyword').value
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