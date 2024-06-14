# frozen_string_literal: true

require "graphql"
require "batch-loader"

module Phantom::Graphql
end

require "phantom/graphql/field_extensions"
require "phantom/graphql/enum"
require "phantom/graphql/response"

GraphQL::Schema.use(BatchLoader::GraphQL)

GraphQL::Schema::InputObject.extend(Phantom::Graphql::Enum)
GraphQL::Schema::Object.extend(Phantom::Graphql::Enum)
GraphQL::Schema::RelayClassicMutation.extend(Phantom::Graphql::Enum)

GraphQL::Schema.include(Phantom::Graphql::Response::ExceptionsHandler)
GraphQL::Schema::RelayClassicMutation.include(Phantom::Graphql::Response::Helpers)
