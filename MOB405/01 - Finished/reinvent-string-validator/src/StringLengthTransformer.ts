import {
    ObjectTypeDefinitionNode,
    DirectiveNode,
    InterfaceTypeDefinitionNode,
    FieldDefinitionNode,
    Kind,
} from "graphql";
import {
    Transformer,
    TransformerContext,
    InvalidDirectiveError,
    gql,
    getDirectiveArguments,
} from "graphql-transformer-core";
import {
    ResolverResourceIDs,
    isNonNullType,
    STANDARD_SCALARS,
    unwrapNonNull,
} from "graphql-transformer-common";
import {
    printBlock,
    iff,
    raw,
    Expression,
    or,
    ref,
} from "graphql-mapping-template";

const DEFAULT_MAX_STRING_LENGTH: number = 200;

export default class StringLengthTransformer extends Transformer {

    constructor() {
        super(
            "StringLengthTransformer",
            gql`
            directive @length(minLength: Int!, maxLength: Int) on FIELD_DEFINITION
            `
        );
    }

    public field = (
        parent: ObjectTypeDefinitionNode | InterfaceTypeDefinitionNode,
        definition: FieldDefinitionNode,
        directive: DirectiveNode,
        ctx: TransformerContext
    ) => {
        if (parent.kind === Kind.INTERFACE_TYPE_DEFINITION) {
            throw new InvalidDirectiveError(
                `The @length directive cannot be placed on an interface's field. See ${parent.name.value}${definition.name.value}`
            );
        }

        // Validation - @model required
        this.validateParentModelDirective(parent!);

        // Validation - non-nullable String required
        this.validateStringFieldType(definition);

        // Validation - minLength is mandatory, while maxLength is optional, but
        // graphql validation catches that requirement, we only need to validate
        // ranges
        let { minLength, maxLength } = getDirectiveArguments(directive);

        this.validateArguments(minLength, maxLength);

        // If no maxLength was specifed use the default as an upper range
        // VTL code requires it to be present
        if (!maxLength) {
            maxLength = DEFAULT_MAX_STRING_LENGTH;
        }

        // Generate the VTL code block
        const typeName = parent.name.value;
        const fieldName = definition.name.value;

        const validationExpression = this.generateValidationExpression(fieldName, minLength, maxLength);

        const vtlCode = printBlock(`Length validation for "${fieldName}" (${minLength}-${maxLength})`)(validationExpression);

        // Update create and update mutations
        const createResolverResourceId = ResolverResourceIDs.DynamoDBCreateResolverResourceID(
            typeName
        );
        this.updateResolver(ctx, createResolverResourceId, vtlCode);

        const updateResolverResourceId = ResolverResourceIDs.DynamoDBUpdateResolverResourceID(
            typeName
        );
        this.updateResolver(ctx, updateResolverResourceId, vtlCode);
    };

    private validateParentModelDirective = (type: ObjectTypeDefinitionNode) => {
        const directive = type!.directives!.find(d => d.name.value === 'model');

        if (!directive) {
            throw new Error(`@length directive can only be used on types with @model directive.`);
        }
    }

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

    private validateArguments = (minLength: number, maxLength: number) => {
        if (maxLength && maxLength<minLength) {
            throw new InvalidDirectiveError(`maxLength (${maxLength}) must be less or equal than minLength (${minLength}) for the @length directive.`);
        }
    }

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

    private updateResolver = (ctx: TransformerContext, resolverResourceId: string, code: string) => {
        const resolver = ctx.getResource(resolverResourceId);

        if (resolver) {
            const templateParts = [code, resolver!.Properties!.RequestMappingTemplate];
            resolver!.Properties!.RequestMappingTemplate = templateParts.join('\n\n');
            ctx.setResource(resolverResourceId, resolver);
        }
    }
}
