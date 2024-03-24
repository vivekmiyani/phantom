# frozen_string_literal: true

require "graphql"

module Phantom::Graphql
end

require "phantom/graphql/enum"

GraphQL::Schema::InputObject.extend(Phantom::Graphql::Enum)
GraphQL::Schema::Object.extend(Phantom::Graphql::Enum)
GraphQL::Schema::RelayClassicMutation.extend(Phantom::Graphql::Enum)
