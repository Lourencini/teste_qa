# frozen_string_literal: true

# require_relative "../services/base_service.rb"

describe 'fazer uma requisição' do
  
  it 'Validando formato do request' do

puts "\n 1. Validar o formato do request (json valido) para a seguinte API: https://swapi.co/api/films/?format=json"

    @valida_formato = Acesso.get('/films/?format=json')
    puts "O formato do retornado do request foi: #{@valida_formato.headers['Content-Type'].to_json}"
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
      puts "Verifique a URL informada para o request, retorno foi #{@valida_url.code}:#{@valida_url}"
    else 
      puts "A URL informada para o request é valida"
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

    if @valida_titulo['title'] == "The Force Awakens"
      puts "O filme pesquisado foi #{@valida_titulo['title']}, o título está correto."
    else
      puts "O título do filme é invalido, o título #{@valida_titulo['title']}, está incorreto"
    end
    expect(@valida_titulo['title']).to eq "The Force Awakens"
  end
end
