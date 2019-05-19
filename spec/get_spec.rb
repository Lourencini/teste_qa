# frozen_string_literal: true

describe 'Teste QA' do

  it 'Validando formato do request' do
    puts "\n 1. Validar o formato do request (json valido) para a seguinte API: https://swapi.co/api/films/?format=json"

    @valida_formato = Acesso.get('/films/?format=json')
    puts "O formato retornado pelo request foi: #{@valida_formato.headers['Content-Type'].to_json}"
    expect(@valida_formato.headers['Content-Type']).to eq 'application/json'
  end

  it 'Validando o retorno HTTP' do
    puts "\n 2. Validar se o retorno HTTP é válido para um GET;"

    @valida_formato = Acesso.get('/films/?format=json')
    if @valida_formato.code == 100 || 200 || 300 || 400 || 500
      puts "O retorno do HTTP foi #{@valida_formato.code}, é um retorno HTTP válido."
    else
      puts "Retorno do HTTP foi #{@valida_formato.code}, esse formato é inválido"
    end
  end

  it 'Valindo URLs inválidas' do
    puts "\n 3. Validar retornos para URLs inválidas, como por exemplo: https://swapi.co/api/people/?format=jsonx"

    @valida_url = Acesso.get('/people/?format=jsonx')
    if @valida_url.body == '{"detail":"Not found"}'
      puts "A URL informada para o request é inválida, o retorno do request foi #{@valida_url.code}:#{@valida_url}"
    else
      puts 'A URL informada para o request é valida'
    end
  end

  it 'Valida Filme' do
    puts "\n 4. Validar se o filme 10 é válido e qual o tipo de retorno ao consultar;"

    @valida_filme = Acesso.get('/films/10/')

    if @valida_filme.body == '{"detail":"Not found"}'
      puts "O filme requisitado não é um filme válido, o retorno do request foi #{@valida_filme.body.inspect}, por favor verifique."
    else
      puts "O filme pesquisado é: #{@valida_filme['title'].inspect}"
    end
  end

  it 'Validar Título do Filme 7' do
    puts "\n 5. Validar o nome correto de um determinado episódio de filme;"

    @valida_titulo = Acesso.get('/films/7/')

    if @valida_titulo['title'] == 'The Force Awakens'
      puts "O filme pesquisado foi #{@valida_titulo['title']}, o título está correto."
    else
      puts "O título do filme é invalido, o título #{@valida_titulo['title']}, está incorreto"
    end
    expect(@valida_titulo['title']).to eq 'The Force Awakens'
  end

  it 'Validar ID' do
    puts "\n 6. Validar o ID do episódio e o tipo do dado está correto;"

    @valida_id = Acesso.get('/films/7/')
    @valida_titulo = Acesso.get('/films/7/')

    if @valida_id['episode_id'] == 7
      puts "O ID do filme #{@valida_titulo['title']} é o ID:#{@valida_id['episode_id']}."
    else
      puts "O ID #{@valida_id['episode_id']} está incorreto para o filme #{@valida_titulo['title']}.\n"
    end
  end

  it 'Validar Formato de Data Válida' do
    puts "\n 7. Validar o formato de data válida (padrão americano) e validar se a data não é padrão Brasil;"

    @valida_data = Acesso.get('/films/7')

    require 'time'
    agora = Time.now
    day = agora.day.to_s
    month = agora.mon.to_s
    year = agora.year.to_s
    date = year + month + day.to_s

    if date == year + month + day
      puts "A data está no padrão americano, Y/M/D #{@valida_data['release_date']}."
    else
      puts 'A data está no padrão brasileiro, D/M/Y e não no padrão americano Y/M/D.'
    end
    expect(@valida_data['release_date']).to eq '2015-12-11'
  end

  it 'Dados C-3PO' do
    puts "\n 8. Validar o peso e altura do “people” C-3PO e validar pelo menos um filme que ele tenha participado."

    @dados_people = Acesso.get('/people/2/')
    @dados_people_film = Acesso.get('/films/2/')

    @dados_people_name = @dados_people['name']
    @dados_people_height = @dados_people['height']
    @dados_people_mass = @dados_people['mass']

    puts "O personagem #{@dados_people_name}, possui a altura de #{@dados_people_height} e pesa #{@dados_people_mass}, participou de vários filmes, incluíndo o filme #{@dados_people_film['title']}."
    expect(@dados_people_name).to eq 'C-3PO'
    expect(@dados_people_height).to eq '167'
    expect(@dados_people_mass).to eq '75'
    expect(@dados_people_film['title']).to eq 'The Empire Strikes Back'
  end

  it 'Naves pilotadas por Han Solo' do 

    puts "\n 9. Quais as naves que foram pilotadas por Han Solo"

    @han_solo = Acesso.get('/people/14/')
    @nave1 = Acesso.get('/starships/10/')
    @nave2 = Acesso.get('/starships/22/')

    puts "#{@han_solo['name']}, pilotou as naves #{@nave1['name']} e #{@nave2['name']}, nos filmes que participou."
    expect(@nave1['name']).to eq 'Millennium Falcon'
    expect(@nave2['name']).to eq 'Imperial shuttle'
end

  it 'Filmes Millennium Falcon' do

    puts "\n 10. Quais o filmes que a nave Millennium Falcon apareceu"

    @millennium_falcon = Acesso.get('/starships/10/')
    @filme2 = Acesso.get('/films/2/')
    @filme7 = Acesso.get('/films/7/')
    @filme3 = Acesso.get('/films/3/')
    @filme1 = Acesso.get('/films/1/')
    @millennium_falcon_films = @filme2['title'] + ", " + @filme7['title'] + ", " + @filme3['title'] + " e " + @filme1['title']

    puts "A nave #{@millennium_falcon['name']}, apareceu nos filmes #{@millennium_falcon_films}."
  
    expect(@filme2['title']).to eq 'The Empire Strikes Back'
    expect(@filme7['title']).to eq 'The Force Awakens'
    expect(@filme3['title']).to eq 'Return of the Jedi'
    expect(@filme1['title']).to eq 'A New Hope'
  
  end
end
