import { ObjectTypeDefinitionNode, DirectiveNode, InterfaceTypeDefinitionNode, FieldDefinitionNode, Kind } from "graphql";
import { Transformer, TransformerContext, InvalidDirectiveError, gql, getDirectiveArguments } from "graphql-transformer-core";
import { ResolverResourceIDs, isNonNullType, STANDARD_SCALARS, unwrapNonNull } from "graphql-transformer-common";
import { printBlock, iff, raw, Expression, or, ref } from "graphql-mapping-template";

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

        console.log("StringLengthTransformer invoked!");
    };
}
