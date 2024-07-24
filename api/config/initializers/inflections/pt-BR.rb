ActiveSupport::Inflector.inflections(:'pt-BR') do |inflect|
  inflect.clear

  inflect.plural(/$/, 's')
  inflect.plural(/r$/i, 'res')
  inflect.plural(/al$/i, 'ais')
  inflect.plural(/el$/i, 'eis')
  inflect.plural(/il$/i, 'is')
  inflect.plural(/ul$/i, 'uis')
  inflect.plural(/ol$/i, 'ois')
  inflect.plural(/m$/i, 'ns')
  inflect.plural(/ão$/i, 'ões')

  inflect.singular(/s$/, '')
  inflect.singular(/res$/i, 'r')
  inflect.singular(/ais$/i, 'al')
  inflect.singular(/eis$/i, 'el')
  inflect.singular(/is$/i, 'il')
  inflect.singular(/uis$/i, 'ul')
  inflect.singular(/ois$/i, 'ol')
  inflect.singular(/ns$/i, 'm')
  inflect.singular(/ões$/i, 'ão')

  inflect.irregular('cão', 'cães')
  inflect.irregular('pão', 'pães')
  inflect.irregular('mão', 'mãos')
end
