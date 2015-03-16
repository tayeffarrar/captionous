console.log("everything is ok at pictures.js");

var keyword;

$(function(){
	$.ajax({
		url: '/pictures',
		method: 'GET',
		dataType: 'json',
		success: renderResults 
	})
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
			success: renderResults
		})
	})

function renderPicture(picture){
	console.log(picture)
	$link = $('<a></a>').attr("href", picture.url);
											.attr("target", "_blank");
		$img = $('<img>').attr("src", picture.url);
		return $link.append($img);
}

	function renderResults() {
		var $results = $("#results")
		$results.empty()
		pictures.forEach(function(picture){			
			$results.append(renderPicture(picture));	
		});
	};






