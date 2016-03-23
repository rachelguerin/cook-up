# Preview all emails at http://localhost:3000/rails/mailers/menu_mailer
class MenuMailerPreview < ActionMailer::Preview
	def shopping_list_preview
		MenuMailer.shopping_list("21,23,24,25,26","rachel.guerin23@gmail.com")
	end
end
