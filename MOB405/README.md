# AWS re:Invent 2019 - MOB405 AWS Amplify CLI: Make it work for you

This repositry contains the source code for the builder session.

In this builder session, participants are developing a custom GraphQL transformer for the Amplify CLI and testing it.

```00 - Start``` directory contains the starter project for the builder session, but for the curious, ```Starting from scratch.md``` contains the steps to get to that point.
```01 - Finished``` directory contains the finished project.

## Summary

In this builder session we're creating a string length validator GraphQL directive that could be used on type definition fields in the GraphQL schema. As its name says, the directive is validating the given field's length and if it is out range, provides a detailed error message that can be handled in the application client code in a user friendly way, by providing details about the validation error that happened.

In the beginning an empty custom transformer skeleton code is wired up in a test project where the GraphQL schema already uses the @length directive.

## Functional requirements

- Support non-nullable string type field string length validation
- Validation: directive usage (GraphQL node type), field type, directive arguments
- Generate VTL code for validation
- Support create and update mutations
- Provide rich error information

## Directive definition

```graphql
directive @length(minLength: Int!, maxLength: Int) on FIELD_DEFINITION
```

## Implementation steps

> All the modifications must be made in the transformer.

### Validations

Validate that the directive was added on a type definition node, we don't support interfaces

```typescript
if (parent.kind === Kind.INTERFACE_TYPE_DEFINITION) {
    throw new InvalidDirectiveError(
        `The @length directive cannot be placed on an interface's field. See ${parent.name.value}${definition.name.value}`
    );
}
```

Validate that the directive was added on a type which has ```@model``` directive, so the Amplify CLI handles the resolver generation for it.

```typescript
// Validation - @model required
this.validateParentModelDirective(parent!);
```

Add the method implementation to the class:

```typescript
private validateParentModelDirective = (type: ObjectTypeDefinitionNode) => {
    const directive = type!.directives!.find(d => d.name.value === 'model');

    if (!directive) {
        throw new Error(`@length directive can only be used on types with @model directive.`);
    }
}
```

Validate that the directive was added on a field which has non-nullable String type.

```typescript
// Validation - non-nullable String required
this.validateStringFieldType(definition);
```

Add the method implementation to the class:

```typescript
private validateStringFieldType = (field: FieldDefinitionNode) => {
    // Only non-nullable String fields are valid
    let isValidType = false;
    let fieldTypeName;

    if (isNonNullType(field.type)) {
        const unwrappedType = unwrapNonNull(field.type);
        fieldTypeName = unwrappedType.name.value;
        isValidType = fieldTypeName === STANDARD_SCALARS.String;
    } else {
        throw new InvalidDirectiveError(`@length directive can only be used on non-nullable String type fields`);
    }

    if (!isValidType) {
        throw new InvalidDirectiveError(`@length directive can only be used on non-nullable String type fields, '${field.name.value}' is type of '${fieldTypeName}'`);
    }
}
```

Validate that the directive arguments are representing a valid range, if no upper range was defined assign a default maximum length.

```typescript
// Validation - minLength is mandatory, while maxLength is optional, but
// graphql validation catches that requirement, we only need to validate
// ranges
let { minLength, maxLength } = getDirectiveArguments(directive);

this.validateArguments(minLength, maxLength);

const DEFAULT_MAX_STRING_LENGTH: number = 200;

// If no maxLength was specifed use the default as an upper range
// VTL code requires it to be present
if (!maxLength) {
    maxLength = DEFAULT_MAX_STRING_LENGTH;
}
```

Add the method implementation to the class:

```typescript
private validateArguments = (minLength: number, maxLength: number) => {
    if (maxLength && maxLength<minLength) {
        throw new InvalidDirectiveError(`maxLength (${maxLength}) must be less or equal than minLength (${minLength}) for the @length directive.`);
    }
}
```

Now as the validations are done, we've to create the code that generates a string validation VTL code. The following code is an example snippet we have to generate:

```velocity
#if( $ctx.args.input.name.length() < 5 || $ctx.args.input.name.length() > 10 )
$util.error(
    "Input validation error",
    "validationError",
    null,
    {
        "type": "length",
        "fieldName": "name",
        "minLength": 5,
        "maxLength": 10
    }
)
#end
```

Add the code for the code generation. First we generate the abstract syntax tree representation of the code above, then it is printed to a string, that can be prepended to the code of the resolver.

```typescript
// Generate the VTL code block
const typeName = parent.name.value;
const fieldName = definition.name.value;

const validationExpression = this.generateValidationExpression(fieldName, minLength, maxLength);

const vtlCode = printBlock(`Length validation for "${fieldName}" (${minLength}-${maxLength})`)(validationExpression);
```

Add the method implementation to the class:

```typescript
private generateValidationExpression = (fieldName: string, minLength: number, maxLength: number): Expression => {
    return iff(
            or([
                raw(`$ctx.args.input.${fieldName}.length() < ${minLength}`),
                raw(`$ctx.args.input.${fieldName}.length() > ${maxLength}`)
            ]),
            ref(`util.error(
                "Input validation error",
                "validationError",
                null,
                {
                    "type": "length",
                    "fieldName": "${fieldName}",
                    "minLength": ${minLength},
                    "maxLength": ${maxLength}
                })`
            )
    );
}
```

One final step left, to add the generated code to the existing create and update resolvers.

```typescript
        // Update create and update mutations
        const createResolverResourceId = ResolverResourceIDs.DynamoDBCreateResolverResourceID(
            typeName
        );
        this.updateResolver(ctx, createResolverResourceId, vtlCode);

        const updateResolverResourceId = ResolverResourceIDs.DynamoDBUpdateResolverResourceID(
            typeName
        );
        this.updateResolver(ctx, updateResolverResourceId, vtlCode);
```

Add the method implementation to the class:

```typescript
private updateResolver = (ctx: TransformerContext, resolverResourceId: string, code: string) => {
    const resolver = ctx.getResource(resolverResourceId);

    if (resolver) {
        const templateParts = [code, resolver!.Properties!.RequestMappingTemplate];
        resolver!.Properties!.RequestMappingTemplate = templateParts.join('\n\n');
        ctx.setResource(resolverResourceId, resolver);
    }
}
```

## Testing the transformer

Lets build the project by issuing the following command from the validator's directory:

```
$ npm run build
```

If everything is correct we have a compiled transformer that is already installed in the ```validatortest``` project.

> To check if the project is initialized for Amplify CLI, execute the ```amplify status``` command. If it gives an error about the project is not initialized, then execute ```amplify init```. If Amplify CLI was never configured on the machine, you've to run ```amplify configure``` a one time configuration command before init.

Amplify CLI provides a mocking feature which enables us to test the project locally without an actual cloud deployment. Start the mocking from the ```validatortest``` directory by executing the following command: ```amplify mock```

A similar output should be in the console:

```
The following types do not have '@auth' enabled. Consider using @auth with @model
    - Todo
Learn more about @auth here: https://aws-amplify.github.io/docs/cli-toolchain/graphql#auth


GraphQL schema compiled successfully.

Edit your schema at /mob405/validatortest/amplify/backend/api/validatortest/schema.graphql or place .graphql files in a directory at /mob405/validatortest/amplify/backend/api/validatortest/schema
Creating table TodoTable locally
Running GraphQL codegen
✔ Generated GraphQL operations successfully and saved at src/graphql
AppSync Mock endpoint is running at http://0.0.0.0:20002
```

Open a browser window with address above and test out the validation by executing the following mutations one-by-one.

```graphql
mutation TooShortTodo {
  createTodo (input: {
    name: "one"
    description: "You shall not pass!"
  }) {
    id
    name
    description
  }
}

mutation TooLongTodo {
  createTodo (input: {
    name: "more-than-ten-characters"
    description: "You shall not pass!"
  }) {
    id
    name
    description
  }
}

mutation PerfectTodo {
  createTodo (input: {
    name: "good-one"
    description: "Good job, it's a passing one"
  }) {
    id
    name
    description
  }
}

query ListTodos {
  listTodos {
    items {
      id
      name
      description
    }
  }
}
```

As we can see the validation worked and in two cases we got the proper error messages and only 1 todo was inserted into the DynamoDB datastore.

## Cleanup cloud deployment

To remove the resources that were deployed by ```amplify init``` issue the following command from the ```validatortest``` folder:

```
$ amplify delete
```

At this point all the resources are removed from the cloud.
