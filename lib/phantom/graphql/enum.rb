# frozen_string_literal: true

module Phantom::Graphql::Enum
  def enum(type_name, values)
    Class.new(Types::BaseEnum) do
      graphql_name type_name

      values.each do |v|
        value(v, value: v)
      end
    end
  end
end
