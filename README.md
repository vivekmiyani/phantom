# Phantom

## Graphql

Includes `enum` shorthand,

```rb
field :status, enum("PersonStatusEnum", Person.statuses.keys), null: false
```
