# EdiParser

Biblioteca para fazer o parse de arquivos de ocorrências de entrega conforme o [padrão EDI COTIN/SETCESP](http://www.setcesp.org.br/cotin/index.asp).

Aqui você encontra a planilha com o layout do arquivo de ocorrências: http://www.setcesp.org.br/cotin/OCORENC.XLS

## Como usar

### Instalação

Adicione a biblioteca ao arquivo Gemfile:

```ruby
gem 'edi_parser'
```

### Fazendo o parse dos seus arquivos de ocorrência

```ruby
@edi_file = EdiParser::EdiFile.parse(path_para_seu_arquivo)
```
