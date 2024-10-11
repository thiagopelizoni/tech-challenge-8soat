#!/usr/bin/env ruby

def check_db_initialized
    system("rails db:version > /dev/null 2>&1")
end
  
if check_db_initialized
    system("rails db:migrate")
else
    puts "Inicializando banco de dados"
    system("rails db:create")
    system("rails db:migrate")
    system("rails db:seed")
end
  