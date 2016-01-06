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
				$(".alert").css("color","#ff0000").html("書籍情報が見つかりません")
				console.log("error")
			success: (data) ->
				console.log("success")
				if data?
					$("#book_title").val(data.Title) # タイトル
					$("#book_author").val(data.Author) # 著者
					$("#book_manufacturer").val(data.Manufacturer) # 出版社
				else
					$(".alert").css("color","#ff0000").html("書籍情報が見つかりませんでした。");

	$("#book_isbn").change -> $(".alert").html("")
