# AWS re:Invent 2019 - MOB405 AWS Amplify CLI: Make it work for you

## 1. Folder setup

### Create the folder structure

```
$ mkdir mob405
$ cd mob405

$ git init

$ mkdir reinvent-string-validator
$ mkdir validatortest
```

### Install Amplify CLI

> If there is no Amplify CLI is installed on the machine or if the version of it is less than 4.5.0, make sure you update it to the latest version.

```
$ npm i -g @aws-amplify/cli
```

If this is a fresh install of Amplify CLI, you have to run ```amplify configure``` to create a AWS user and a profile on your machine.

## 2. Transformer setup

### Create the transformer package, add dependencies

```
$ cd reinvent-string-validator

$ npm init -y
$ npm install -D typescript@3.6.4 @types/node@8.10.59 @types/graphql@0.13.4
$ npm install graphql@0.13.2 graphql-mapping-template graphql-transformer-common graphql-transformer-core
```

### Update package.json

```
"main": "./lib/index.js",
"scripts": {
  "test": "jest",
  "build": "tsc",
  "watch": "tsc -w"
}
```

### Configure TypeScript

```
$ ./node_modules/.bin/tsc --init
```

### Update tsconfig.json

```
{
    "compilerOptions": {
        "target": "es5",
        "module": "commonjs",
        "lib": [
            "esnext"
        ],                                        /* Specify library files to be included in the compilation. */
        "declaration": true,                      /* Generates corresponding '.d.ts' file. */
        "sourceMap": true,                        /* Generates corresponding '.map' file. */
        "outDir": "./lib",                        /* Redirect output structure to the directory. */
        "strict": true,                           /* Enable all strict type-checking options. */
        "esModuleInterop": true,                  /* Enables emit interoperability between CommonJS and ES Modules via creation of namespace objects for all imports. Implies 'allowSyntheticDefaultImports'. */
    },
    "exclude": [
        "node_modules",
        "lib"
    ]
}
```

### Create .gitignore

```
$ touch .gitignore
```

#### Add content

```
lib/
node_modules/
```

### Create source files

```
$ mkdir src
$ touch src/index.ts
$ touch src/StringLengthTransformer.ts
```

#### index.ts content

```typescript
export * from "./StringLengthTransformer";
```

#### StringLengthTransformer.ts content

```typescript
import { ObjectTypeDefinitionNode, DirectiveNode, InterfaceTypeDefinitionNode, FieldDefinitionNode, Kind } from "graphql";
import { Transformer, TransformerContext, InvalidDirectiveError, gql, getDirectiveArguments } from "graphql-transformer-core";
import { ResolverResourceIDs, isNonNullType, STANDARD_SCALARS, unwrapNonNull } from "graphql-transformer-common";
import { printBlock, iff, raw, Expression, or, ref } from "graphql-mapping-template";

export default class StringLengthTransformer extends Transformer {
    constructor() {
        super(
            "StringLengthTransformer",
            gql`directive @length(minLength: Int!, maxLength: Int) on FIELD_DEFINITION`
        );
    }

    public field = (parent: ObjectTypeDefinitionNode | InterfaceTypeDefinitionNode, definition: FieldDefinitionNode, directive: DirectiveNode, ctx: TransformerContext) => {
        console.log("StringLengthTransformer invoked!");
    };
}
```

## 3. Test project setup

### Initialize package, init Amplify project and add a GraphQL API

```
$ cd ../validatortest
$ npm init -y
$ amplify init (default options are ok, pick an environment name)
```

```
$ amplify api add (default options, select Todo schema)
```

#### Update the Todo type's name field in the graphql schema

```
name: String! @length(minLength: 5, maxLength: 10)
```

### Add the validator to ```devDependencies``` in package.json

```
"devDependencies": {
    "reinvent-string-validator": "../reinvent-string-validator"
}
```

### Add validator transformer to list of custom transformers in amplify/backend/api/validatortest/transform.conf.json

```
"transformers": [
    "./reinvent-string-validator"
]
```

> Using local path will instruct the module loader to look for project local packages, not globally installed ones.

## 4. Test validator

```
$ npm install
$ amplify api gql-compile
```

If "StringLengthTransformer invoked!" printed to the console during GraphQL schema compilation congratulations, you configured your first custom GraphQL transformer for Amplify CLI!
