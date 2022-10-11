class WordReader

	def read_from_file(file_name)

		begin
			f = File.new(file_name,"r:UTF-8")
			file = f.readlines
			f.close
			return file.sample.chomp
		rescue SystemCallError
			abort "Файл со словами не найден!!!"
		end

	end

end