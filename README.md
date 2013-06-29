[![Build Status](https://travis-ci.org/matheustardivo/edi_parser.png?branch=master)](https://travis-ci.org/matheustardivo/edi_parser)
[![Coverage Status](https://coveralls.io/repos/matheustardivo/edi_parser/badge.png)](https://coveralls.io/r/matheustardivo/edi_parser)

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

### Documentação

Veja no [RubyDoc.info](http://rubydoc.info) em: http://rubydoc.info/github/matheustardivo/edi_parser/master/frames

As principais classes são:
* [EdiParser::EdiFile](http://rubydoc.info/github/matheustardivo/edi_parser/master/EdiParser/EdiFile)
* [EdiParser::InterchangeHeader](http://rubydoc.info/github/matheustardivo/edi_parser/master/EdiParser/InterchangeHeader)
* [EdiParser::DocumentHeader](http://rubydoc.info/github/matheustardivo/edi_parser/master/EdiParser/DocumentHeader)
* [EdiParser::CarrierData](http://rubydoc.info/github/matheustardivo/edi_parser/master/EdiParser/CarrierData)
