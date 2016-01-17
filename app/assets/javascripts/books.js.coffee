$ ->
	$("#info_search_button").click ->
		isbncode = $('#book_isbn').val()
		user_id = $('#book_user_id').val()
		$.ajax
			async: true
			url: "/users/#{user_id}/books/new/get_info/"
			type: "GET"
			data: {isbn: isbncode}
			dataType: "json"
			context: this
			error: (XMLHttpRequest, textStatus, errorThrown) ->
				$(".mes").html("<div class='alert fade in alert-danger'>書籍情報が見つかりません</div>")
				console.log("error")
			success: (data) ->
				console.log("success")
				console.log(data)
				if data?
					$("#book_title").val(data.Title) # タイトル
					$("#book_author").val(data.Author) # 著者
					$("#book_manufacturer").val(data.Manufacturer) # 出版社
					$("#book_image_url").val(data.ImageURL) # URL
				else
				$(".mes").html("<div class='alert fade in alert-danger'>書籍情報が見つかりません</div>")
			$("#book_isbn").change ->
				$(".mes").html("")
