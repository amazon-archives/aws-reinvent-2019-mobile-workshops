//  This file was automatically generated and should not be edited.

import AWSAppSync

public struct CreateLandmarkInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID? = nil, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: CoordinateInput? = nil, imageName: String? = nil) {
    graphQLMap = ["id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates, "imageName": imageName]
  }

  public var id: GraphQLID? {
    get {
      return graphQLMap["id"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var category: String? {
    get {
      return graphQLMap["category"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category")
    }
  }

  public var city: String? {
    get {
      return graphQLMap["city"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  public var state: String? {
    get {
      return graphQLMap["state"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  public var isFeatured: Bool? {
    get {
      return graphQLMap["isFeatured"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isFeatured")
    }
  }

  public var isFavorite: Bool? {
    get {
      return graphQLMap["isFavorite"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isFavorite")
    }
  }

  public var park: String? {
    get {
      return graphQLMap["park"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "park")
    }
  }

  public var coordinates: CoordinateInput? {
    get {
      return graphQLMap["coordinates"] as! CoordinateInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coordinates")
    }
  }

  public var imageName: String? {
    get {
      return graphQLMap["imageName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "imageName")
    }
  }
}

public struct CoordinateInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(longitude: Double? = nil, latitude: Double? = nil) {
    graphQLMap = ["longitude": longitude, "latitude": latitude]
  }

  public var longitude: Double? {
    get {
      return graphQLMap["longitude"] as! Double?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "longitude")
    }
  }

  public var latitude: Double? {
    get {
      return graphQLMap["latitude"] as! Double?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "latitude")
    }
  }
}

public struct UpdateLandmarkInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, name: String? = nil, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: CoordinateInput? = nil, imageName: String? = nil) {
    graphQLMap = ["id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates, "imageName": imageName]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String? {
    get {
      return graphQLMap["name"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var category: String? {
    get {
      return graphQLMap["category"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category")
    }
  }

  public var city: String? {
    get {
      return graphQLMap["city"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  public var state: String? {
    get {
      return graphQLMap["state"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  public var isFeatured: Bool? {
    get {
      return graphQLMap["isFeatured"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isFeatured")
    }
  }

  public var isFavorite: Bool? {
    get {
      return graphQLMap["isFavorite"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isFavorite")
    }
  }

  public var park: String? {
    get {
      return graphQLMap["park"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "park")
    }
  }

  public var coordinates: CoordinateInput? {
    get {
      return graphQLMap["coordinates"] as! CoordinateInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coordinates")
    }
  }

  public var imageName: String? {
    get {
      return graphQLMap["imageName"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "imageName")
    }
  }
}

public struct DeleteLandmarkInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID? = nil) {
    graphQLMap = ["id": id]
  }

  public var id: GraphQLID? {
    get {
      return graphQLMap["id"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public struct ModelLandmarkFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: ModelIDFilterInput? = nil, name: ModelStringFilterInput? = nil, category: ModelStringFilterInput? = nil, city: ModelStringFilterInput? = nil, state: ModelStringFilterInput? = nil, isFeatured: ModelBooleanFilterInput? = nil, isFavorite: ModelBooleanFilterInput? = nil, park: ModelStringFilterInput? = nil, imageName: ModelStringFilterInput? = nil, and: [ModelLandmarkFilterInput?]? = nil, or: [ModelLandmarkFilterInput?]? = nil, not: ModelLandmarkFilterInput? = nil) {
    graphQLMap = ["id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "imageName": imageName, "and": and, "or": or, "not": not]
  }

  public var id: ModelIDFilterInput? {
    get {
      return graphQLMap["id"] as! ModelIDFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: ModelStringFilterInput? {
    get {
      return graphQLMap["name"] as! ModelStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var category: ModelStringFilterInput? {
    get {
      return graphQLMap["category"] as! ModelStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category")
    }
  }

  public var city: ModelStringFilterInput? {
    get {
      return graphQLMap["city"] as! ModelStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "city")
    }
  }

  public var state: ModelStringFilterInput? {
    get {
      return graphQLMap["state"] as! ModelStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  public var isFeatured: ModelBooleanFilterInput? {
    get {
      return graphQLMap["isFeatured"] as! ModelBooleanFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isFeatured")
    }
  }

  public var isFavorite: ModelBooleanFilterInput? {
    get {
      return graphQLMap["isFavorite"] as! ModelBooleanFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "isFavorite")
    }
  }

  public var park: ModelStringFilterInput? {
    get {
      return graphQLMap["park"] as! ModelStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "park")
    }
  }

  public var imageName: ModelStringFilterInput? {
    get {
      return graphQLMap["imageName"] as! ModelStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "imageName")
    }
  }

  public var and: [ModelLandmarkFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelLandmarkFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelLandmarkFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelLandmarkFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelLandmarkFilterInput? {
    get {
      return graphQLMap["not"] as! ModelLandmarkFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelIDFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }
}

public struct ModelStringFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }
}

public struct ModelBooleanFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: Bool? = nil, eq: Bool? = nil) {
    graphQLMap = ["ne": ne, "eq": eq]
  }

  public var ne: Bool? {
    get {
      return graphQLMap["ne"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: Bool? {
    get {
      return graphQLMap["eq"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }
}

public final class CreateLandmarkMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateLandmark($input: CreateLandmarkInput!) {\n  createLandmark(input: $input) {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public var input: CreateLandmarkInput

  public init(input: CreateLandmarkInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createLandmark", arguments: ["input": GraphQLVariable("input")], type: .object(CreateLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createLandmark: CreateLandmark? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createLandmark": createLandmark.flatMap { $0.snapshot }])
    }

    public var createLandmark: CreateLandmark? {
      get {
        return (snapshot["createLandmark"] as? Snapshot).flatMap { CreateLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createLandmark")
      }
    }

    public struct CreateLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}

public final class UpdateLandmarkMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateLandmark($input: UpdateLandmarkInput!) {\n  updateLandmark(input: $input) {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public var input: UpdateLandmarkInput

  public init(input: UpdateLandmarkInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateLandmark", arguments: ["input": GraphQLVariable("input")], type: .object(UpdateLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateLandmark: UpdateLandmark? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateLandmark": updateLandmark.flatMap { $0.snapshot }])
    }

    public var updateLandmark: UpdateLandmark? {
      get {
        return (snapshot["updateLandmark"] as? Snapshot).flatMap { UpdateLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateLandmark")
      }
    }

    public struct UpdateLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}

public final class DeleteLandmarkMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteLandmark($input: DeleteLandmarkInput!) {\n  deleteLandmark(input: $input) {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public var input: DeleteLandmarkInput

  public init(input: DeleteLandmarkInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteLandmark", arguments: ["input": GraphQLVariable("input")], type: .object(DeleteLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteLandmark: DeleteLandmark? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteLandmark": deleteLandmark.flatMap { $0.snapshot }])
    }

    public var deleteLandmark: DeleteLandmark? {
      get {
        return (snapshot["deleteLandmark"] as? Snapshot).flatMap { DeleteLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteLandmark")
      }
    }

    public struct DeleteLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}

public final class GetLandmarkQuery: GraphQLQuery {
  public static let operationString =
    "query GetLandmark($id: ID!) {\n  getLandmark(id: $id) {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getLandmark", arguments: ["id": GraphQLVariable("id")], type: .object(GetLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getLandmark: GetLandmark? = nil) {
      self.init(snapshot: ["__typename": "Query", "getLandmark": getLandmark.flatMap { $0.snapshot }])
    }

    public var getLandmark: GetLandmark? {
      get {
        return (snapshot["getLandmark"] as? Snapshot).flatMap { GetLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getLandmark")
      }
    }

    public struct GetLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}

public final class ListLandmarksQuery: GraphQLQuery {
  public static let operationString =
    "query ListLandmarks($filter: ModelLandmarkFilterInput, $limit: Int, $nextToken: String) {\n  listLandmarks(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      name\n      category\n      city\n      state\n      isFeatured\n      isFavorite\n      park\n      coordinates {\n        __typename\n        longitude\n        latitude\n      }\n      imageName\n    }\n    nextToken\n  }\n}"

  public var filter: ModelLandmarkFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(filter: ModelLandmarkFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listLandmarks", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listLandmarks: ListLandmark? = nil) {
      self.init(snapshot: ["__typename": "Query", "listLandmarks": listLandmarks.flatMap { $0.snapshot }])
    }

    public var listLandmarks: ListLandmark? {
      get {
        return (snapshot["listLandmarks"] as? Snapshot).flatMap { ListLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listLandmarks")
      }
    }

    public struct ListLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelLandmarkConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .list(.object(Item.selections))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?]? = nil, nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelLandmarkConnection", "items": items.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?]? {
        get {
          return (snapshot["items"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Item(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Landmark"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("category", type: .scalar(String.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("state", type: .scalar(String.self)),
          GraphQLField("isFeatured", type: .scalar(Bool.self)),
          GraphQLField("isFavorite", type: .scalar(Bool.self)),
          GraphQLField("park", type: .scalar(String.self)),
          GraphQLField("coordinates", type: .object(Coordinate.selections)),
          GraphQLField("imageName", type: .scalar(String.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
          self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        public var category: String? {
          get {
            return snapshot["category"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "category")
          }
        }

        public var city: String? {
          get {
            return snapshot["city"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "city")
          }
        }

        public var state: String? {
          get {
            return snapshot["state"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        public var isFeatured: Bool? {
          get {
            return snapshot["isFeatured"] as? Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "isFeatured")
          }
        }

        public var isFavorite: Bool? {
          get {
            return snapshot["isFavorite"] as? Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "isFavorite")
          }
        }

        public var park: String? {
          get {
            return snapshot["park"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "park")
          }
        }

        public var coordinates: Coordinate? {
          get {
            return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
          }
        }

        public var imageName: String? {
          get {
            return snapshot["imageName"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "imageName")
          }
        }

        public struct Coordinate: GraphQLSelectionSet {
          public static let possibleTypes = ["Coordinate"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("longitude", type: .scalar(Double.self)),
            GraphQLField("latitude", type: .scalar(Double.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(longitude: Double? = nil, latitude: Double? = nil) {
            self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var longitude: Double? {
            get {
              return snapshot["longitude"] as? Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "longitude")
            }
          }

          public var latitude: Double? {
            get {
              return snapshot["latitude"] as? Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "latitude")
            }
          }
        }
      }
    }
  }
}

public final class OnCreateLandmarkSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateLandmark {\n  onCreateLandmark {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateLandmark", type: .object(OnCreateLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateLandmark: OnCreateLandmark? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateLandmark": onCreateLandmark.flatMap { $0.snapshot }])
    }

    public var onCreateLandmark: OnCreateLandmark? {
      get {
        return (snapshot["onCreateLandmark"] as? Snapshot).flatMap { OnCreateLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateLandmark")
      }
    }

    public struct OnCreateLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}

public final class OnUpdateLandmarkSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateLandmark {\n  onUpdateLandmark {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateLandmark", type: .object(OnUpdateLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateLandmark: OnUpdateLandmark? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateLandmark": onUpdateLandmark.flatMap { $0.snapshot }])
    }

    public var onUpdateLandmark: OnUpdateLandmark? {
      get {
        return (snapshot["onUpdateLandmark"] as? Snapshot).flatMap { OnUpdateLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateLandmark")
      }
    }

    public struct OnUpdateLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}

public final class OnDeleteLandmarkSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteLandmark {\n  onDeleteLandmark {\n    __typename\n    id\n    name\n    category\n    city\n    state\n    isFeatured\n    isFavorite\n    park\n    coordinates {\n      __typename\n      longitude\n      latitude\n    }\n    imageName\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteLandmark", type: .object(OnDeleteLandmark.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteLandmark: OnDeleteLandmark? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteLandmark": onDeleteLandmark.flatMap { $0.snapshot }])
    }

    public var onDeleteLandmark: OnDeleteLandmark? {
      get {
        return (snapshot["onDeleteLandmark"] as? Snapshot).flatMap { OnDeleteLandmark(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteLandmark")
      }
    }

    public struct OnDeleteLandmark: GraphQLSelectionSet {
      public static let possibleTypes = ["Landmark"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("category", type: .scalar(String.self)),
        GraphQLField("city", type: .scalar(String.self)),
        GraphQLField("state", type: .scalar(String.self)),
        GraphQLField("isFeatured", type: .scalar(Bool.self)),
        GraphQLField("isFavorite", type: .scalar(Bool.self)),
        GraphQLField("park", type: .scalar(String.self)),
        GraphQLField("coordinates", type: .object(Coordinate.selections)),
        GraphQLField("imageName", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, name: String, category: String? = nil, city: String? = nil, state: String? = nil, isFeatured: Bool? = nil, isFavorite: Bool? = nil, park: String? = nil, coordinates: Coordinate? = nil, imageName: String? = nil) {
        self.init(snapshot: ["__typename": "Landmark", "id": id, "name": name, "category": category, "city": city, "state": state, "isFeatured": isFeatured, "isFavorite": isFavorite, "park": park, "coordinates": coordinates.flatMap { $0.snapshot }, "imageName": imageName])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var category: String? {
        get {
          return snapshot["category"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "category")
        }
      }

      public var city: String? {
        get {
          return snapshot["city"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "city")
        }
      }

      public var state: String? {
        get {
          return snapshot["state"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var isFeatured: Bool? {
        get {
          return snapshot["isFeatured"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFeatured")
        }
      }

      public var isFavorite: Bool? {
        get {
          return snapshot["isFavorite"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isFavorite")
        }
      }

      public var park: String? {
        get {
          return snapshot["park"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "park")
        }
      }

      public var coordinates: Coordinate? {
        get {
          return (snapshot["coordinates"] as? Snapshot).flatMap { Coordinate(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "coordinates")
        }
      }

      public var imageName: String? {
        get {
          return snapshot["imageName"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "imageName")
        }
      }

      public struct Coordinate: GraphQLSelectionSet {
        public static let possibleTypes = ["Coordinate"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(longitude: Double? = nil, latitude: Double? = nil) {
          self.init(snapshot: ["__typename": "Coordinate", "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var longitude: Double? {
          get {
            return snapshot["longitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return snapshot["latitude"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "latitude")
          }
        }
      }
    }
  }
}