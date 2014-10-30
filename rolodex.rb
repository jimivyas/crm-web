class Rolodex
	attr_reader :contacts
	def initialize
		@contacts = []
	end

	@@index = 0

	def add_contact(contact)
		contact.id = @@index
		@@index += 1
		@contacts << contact
	end

	def modify_contact(id, attribute, modification)
		id -=1
		case attribute
		when 1 then @contacts[id].first_name = modification
		when 2 then @contacts[id].last_name = modification
		when 3 then @contacts[id].email = modification
		when 4 then @contacts[id].note = modification
		else puts "you should report this error to jimipvyas@gmail.com"
		end
	end

	def find_contact(id)
		@contacts.find { |contact|
			contact.id == id
		}
	end


	def delete_contact(contact)
			@contacts.delete(contact)
	end


	def display_attribute(attribute)
		@contacts.each do |contact|
			case attribute
			when 1 then puts contact.first_name
			when 2 then puts contact.last_name
			when 3 then puts contact.email
			when 4 then puts contact.note
			end
		end
	end




end
