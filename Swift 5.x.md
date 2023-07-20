# Swift 5.x - New Features





## Swift 5.1 - XCode 11

### @propertyWrapper

```swift
@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    var storage: UserDefaults = .standard

    var wrappedValue: Value? {
        get { storage.value(forKey: key) as? Value }
        set { storage.setValue(newValue, forKey: key) }
    }
}

extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "group.johnsundell.app")
        return combined
    }
}

struct SettingsViewModel {
    @UserDefaultsBacked<Bool>(key: "mark-as-read", storage: .shared)
    var autoMarkMessagesAsRead

    @UserDefaultsBacked<Int>(key: "search-page-size", storage: .shared)
    var numberOfSearchResultsPerPage
}
```



### Improvements to synthesized memberwise initializers

```swift
struct User {
    var name: String
    var loginCount: Int = 0
}
// Before 5.1, must be created to accept parameters matching the properties of a struct
let piper = User(name: "Piper Chapman", loginCount: 0) 

// 🎉🎉 In Swift 5.1 this has been enhanced so that the memberwise initializer now uses default parameter values for any properties that have them.
let suzanne = User(name: "Suzanne Warren")
```



### Implicit returns from single-expression functions

```swift
// 🎉🎉 In Swift 5.1, you can leave off the return keyword, like this:
func double(_ number: Int) -> Int {
    number * 2
}
```



### Universal Self

 Swift’s use of `Self` so that it refers to the containing type when used inside classes, structs, and enums.

```swift
class ImprovedNetworkManager {
    class var maximumActiveRequests: Int {
        return 4
    }

    func printDebugData() {
      	// Without Self
      	print("Maximum network requests: \(ImprovedNetworkManager.maximumActiveRequests).")
      	
      	// 🎉🎉 With Self
        print("Maximum network requests: \(Self.maximumActiveRequests).")
    }
}
```



### Static and class subscripts

```swift
public enum NewSettings {
    private static var values = [String: String]()
		// 🎉🎉 Swift 5.1
    public static subscript(_ name: String) -> String? {
        get {
            return values[name]
        }
        set {
            print("Adjusting \(name) to \(newValue ?? "nil")")
            values[name] = newValue
        }
    }
}

NewSettings["Captain"] = "Gary"
NewSettings["Friend"] = "Mooncake"
print(NewSettings["Captain"] ?? "Unknown")
```



### Matching optional enums against non-optionals

```swift
enum BuildStatus {
    case starting
    case inProgress
    case complete
}

let status: BuildStatus? = .inProgress
/// Normally
switch status {
case .some(.inProgress): print("Build is starting…")
case .some(.complete): print("Build is complete!")
default: print("Some other build status")
}

// 🎉🎉 Swift 5.1
switch status {
case .inProgress: print("Build is starting…")
case .complete: print("Build is complete!")
default: print("Some other build status")
}
```



### Ordered collection diffing

Swift 5.1 gives us a new `difference(from:)` method that calculates the differences between two ordered collections – what items to remove and what items to insert. 

```swift
var scores1 = [100, 91, 95, 98, 100]
let scores2 = [100, 98, 95, 91, 100]

// 🎉🎉 Swift 5.1
let diff = scores2.difference(from: scores1)

for change in diff {
    switch change {
    case .remove(let offset, _, _):
        scores1.remove(at: offset)
    case .insert(let offset, let element, _):
        scores1.insert(element, at: offset)
    }
}

print(scores1) // == score2
```



## Swift 5.2 - XCode 11.4

### Key Path Expressions as Functions

```swift
struct User {
    let name: String
    let age: Int
    let bestFriend: String?

    var canVote: Bool {
        age >= 18
    }
}
// Before
let oldUserNames = users.map { $0.name }

// 🎉🎉 Swift 5.2
let userNames = users.map(\.name)
print(userNames)
let voters = users.filter(\.canVote)
```



### Callable values of user-defined nominal types (`callAsFunction()`)

```swift
struct StepCounter {
    var steps = 0

    mutating func callAsFunction(count: Int) -> Bool {
        steps += count
        print(steps)
        return steps > 10_000
    }
}

var steps = StepCounter()
let targetReached = steps(count: 10)
```



### Subscripts can now declare default arguments

```swift
struct PoliceForce {
    var officers: [String]

    subscript(index: Int, default defValue: String = "Unknown") -> String {
        if index >= 0 && index < officers.count {
            return officers[index]
        } else {
            return defValue
        }
    }
}

let force = PoliceForce(officers: ["Amy", "Jake", "Rosa", "Terry"])
// Valid index: 0, 1, 2, 3, 4
print(force[0]) //Amy
print(force[5]) //Unknown
print(force[-1, default: "The Vulture"]) //The Vulture
```



## Swift 5.3 - XCode 12

### Multi-pattern catch clauses

```swift
func checkReactorOperational() throws -> String {
    let temp = getReactorTemperature()

    if temp < 10 {
        throw TemperatureError.tooCold
    } else if temp > 90 {
        throw TemperatureError.tooHot
    } else {
        return "OK"
    }
}

do {
    let result = try checkReactorOperational()
    print("Result: \(result)")
} catch TemperatureError.tooHot, TemperatureError.tooCold {
    print("Shut down the reactor!")
} catch {
    print("An unknown error occurred.")
}
```



### Synthesized Comparable conformance for enums

Lets us opt in to `Comparable` conformance for enums that either have no associated values or **have associated values** that are themselves `Comparable`.

```swift
enum WorldCupResult: Comparable {
    case neverWon
    case winner(stars: Int)
}

let americanMen = WorldCupResult.neverWon
let americanWomen = WorldCupResult.winner(stars: 4)
let japaneseMen = WorldCupResult.neverWon
let japaneseWomen = WorldCupResult.winner(stars: 1)

let teams = [americanMen, americanWomen, japaneseMen, japaneseWomen]
let sortedByWins = teams.sorted()
print(sortedByWins)
```



### `where` clauses on contextually generic declarations

```swift
struct Stack<Element> {
    private var array = [Element]()

    mutating func push(_ obj: Element) {
        array.append(obj)
    }

    mutating func pop() -> Element? {
        array.popLast()
    }
}

extension Stack {
  	// 🎉🎉 Swift 5.3
    func sorted() -> [Element] where Element: Comparable {
        array.sorted()
    }
}
```



### Enum cases as protocol witnesses

```swift
protocol Defaultable {
    static var defaultValue: Self { get }
}

// make integers have a default value of 0
extension Int: Defaultable {
    static var defaultValue: Int { 0 }
}

// make arrays have a default of an empty array
extension Array: Defaultable {
    static var defaultValue: Array { [] }
}

// 🎉🎉 Swift 5.3
enum Padding: Defaultable {
    case pixels(Int)
    case cm(Int)
    case defaultValue
}
```



## Swift 5.4 - XCode 12.5

### Multiple variadic parameters (`...`) in functions

Before Swift 5.4, you could only `have one variadic parameter` in this situation.

```swift
// 🎉🎉 Swift 5.4 with multi-variadic parameter
func summarizeGoals(times: Int..., players: String...) {
    let joinedNames = ListFormatter.localizedString(byJoining: players)
    let joinedTimes = ListFormatter.localizedString(byJoining: times.map(String.init))

    print("\(times.count) goals where scored by \(joinedNames) at the follow minutes: \(joinedTimes)")
}

summarizeGoals(times: 18, 33, 55, 90, players: "Dani", "Jamie", "Roy")
```



### Creating variables that call a function of the same name

```swift
struct Table {
    let count = 10

    func color(forRow row: Int) -> String {
        if row.isMultiple(of: 2) {
            return "red"
        } else {
            return "black"
        }
    }

    func printRows() {
        for i in 0..<count {
          	 // Error “Variable used within its own initial value” in Pre-5.4
            let color = color(forRow: i)because they are same name
            print("Row \(i): \(color)")
        }
    }
}
```



```swift
struct User {
    let username = "Taylor"

    func suggestAlternativeUsername() -> String {
        var username = username // Error in Pre-5.4
        username += String(Int.random(in: 1000...9999))
        return username
    }
}
```



### Local functions now support overloading

```swift
struct Butter { }
struct Flour { }
struct Sugar { }

func makeCookies() {
    func add(item: Butter) {
        print("Adding butter…")
    }

    func add(item: Flour) {
        print("Adding flour…")
    }

    func add(item: Sugar) {
        print("Adding sugar…")
    }

    add(item: Butter())
    add(item: Flour())
    add(item: Sugar())
}
```

Swift 5.4 also lets us call local functions before they are declared

```swift
func makeCookies2() {   
    add(item: Butter())
    add(item: Flour())
    add(item: Sugar())

    func add(item: Butter) {
        print("Adding butter…")
    }

    func add(item: Flour) {
        print("Adding flour…")
    }

    func add(item: Sugar) {
        print("Adding sugar…")
    }
}

makeCookies2()
```



## Swift 5.5 - XCode 13

### Async-Await

```swift
func fetchWeatherHistory() async -> [Double] {
    (1...100_000).map { _ in Double.random(in: -10...30) }
}

func calculateAverageTemperature(for records: [Double]) async -> Double {
    let total = records.reduce(0, +)
    let average = total / Double(records.count)
    return average
}

func upload(result: Double) async -> String {
    "OK"
}

func processWeather() async {
    let records = await fetchWeatherHistory()
    let average = await calculateAverageTemperature(for: records)
    let response = await upload(result: average)
    print("Server response: \(response)")
}

print("START")
Task {
    let result1 = await fetchWeatherHistory(max: 10000)
    print("result1 = \(result1.count)")
    let result2 = await fetchWeatherHistory(max: 200)
    print("result2 = \(result2.count)")
}
print("END")

//START
//END
//result1 = 10000
//result2 = 200
```

#### How to bridge completions handlers to Swift's async/await: 

```swift
// withCheckedContinuation
func load(completion: (Int) -> Void) {
   ...
}

func load() async -> Int {
    return await withCheckedContinuation({ continuation in
        load() { result in
            continuation.resume(returning: result)
        }
    })
}

// withCheckedThrowingContinuation
func load(completion: (Result<Int, Error>) -> Void) {
  ...
}

func load() async throws -> Int {
    return try await withCheckedThrowingContinuation({ continuation in
        load() { result in
            switch result {
            case .success(let successResult):
                continuation.resume(returning: successResult)
            case .failure(let error):
                continuation.resume(throwing: error)
            }

        }
    })
}
```



### get async throws

```swift
enum FileError: Error {
    case missing, unreadable
}

struct BundleFile {
    let filename: String

    var contents: String {
        get async throws {
            guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
                throw FileError.missing
            }

            do {
                return try String(contentsOf: url)
            } catch {
                throw FileError.unreadable
            }
        }
    }
}

func printHighScores() async throws {
    let file = BundleFile(filename: "highscores")
    try await print(file.contents)
}
```



### Structured concurrency

```swift
func printFibonacciSequence() async {
    let task1 = Task { () -> [Int] in
        var numbers = [Int]()

        for i in 0..<50 {
            let result = fibonacci(of: i)
            numbers.append(result)
        }

        return numbers
    }

    let result1 = await task1.value
    print("The first 50 numbers in the Fibonacci sequence are: \(result1)")
}

func runMultipleCalculations() async throws {
    let task1 = Task {
        (0..<50).map(fibonacci)
    }

    let task2 = Task {
        try await getWeatherReadings(for: "Rome")
    }

    let result1 = await task1.value
    let result2 = try await task2.value
    print("The first 50 numbers in the Fibonacci sequence are: \(result1)")
    print("Rome weather readings are: \(result2)")
}


func cancelSleepingTask() async {
    let task = Task { () -> String in
        print("Starting")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        try Task.checkCancellation()
        return "Done"
    }

    // The task has started, but we'll cancel it while it sleeps
    task.cancel()

    do {
        let result = try await task.value
        print("Result: \(result)")
    } catch {
        print("Task was cancelled.")
    }
}
```



### async let bindings

```swift
struct UserData {
    let name: String
    let friends: [String]
    let highScores: [Int]
}

func getUser() async -> String {
    "Taylor Swift"
}

func getHighScores() async -> [Int] {
    [42, 23, 16, 15, 8, 4]
}

func getFriends() async -> [String] {
    ["Eric", "Maeve", "Otis"]
}

func printUserDetails() async {
    async let username = getUser()
    async let scores = getHighScores()
    async let friends = getFriends()

    let user = await UserData(name: username, friends: friends, highScores: scores)
    print("Hello, my name is \(user.name), and I have \(user.friends.count) friends!")
}
```





## Swift 5.6 - XCode 13.3

[What’s new in Swift 5.6? – Hacking with Swift](https://www.hackingwithswift.com/articles/247/whats-new-in-swift-5-6)

## Swift 5.7 - XCode 14

[What’s new in Swift 5.7 – Hacking with Swift](https://www.hackingwithswift.com/articles/249/whats-new-in-swift-5-7)

## Swift 5.8 - XCode 14.3

[What's new in Swift 5.8 – Hacking with Swift](https://www.hackingwithswift.com/articles/256/whats-new-in-swift-5-8)

# Swift 5.9 - XCode 15

[What’s new in Swift 5.9? – Hacking with Swift](https://www.hackingwithswift.com/articles/258/whats-new-in-swift-5-9)
