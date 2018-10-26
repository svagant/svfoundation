import Foundation

/**
 A type that represents `@escaping` function parameter type and emphasizes that
 calling this function is critically important for continuation of the program
 flow. Calling this function is regarded as returning from a function. Never
 calling this function is regarded as fatal as returning `Never`.
 
 - Note: Todays favourite dealing with asynchronicity has rather
 functional oriented character (either using promise/future model or even whole
 reactive design pattern). They have their reason but there are cases where
 we want keep solutions simple and not introduce heavy frameworks and patterns.
 This type is an attempt to introduce a simple convention in order to sanitize
 usage of standard closures and completion handlers critical for a continuation
 of a program flow.
 
 - Note: Deciding to use standard library wisely over non-trivial
 frameworks can be advantage in the near future with next versions of Swift.
 New concurrency model [should be introduced]
 (https://github.com/apple/swift-evolution) no later than in Swift 6.
 [This](https://gist.github.com/lattner/31ed37682ef1576b16bca1432ea9f782) and
 [this](https://gist.github.com/lattner/429b9070918248274f25b714dcfc7619)
 describes what we can expect.
 
 - Attention: Here is the convention.
 While in sync world we are interested in value that function returns on exit,
 in async world we are rather interested in value that is available only after
 the function already exited. To reach this value we use
 [escaping closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html#ID546).
 And here are rules to use them in "AsyncReturn" pattern.
 
 * To emphasize that program is awaiting a value in the callback in order to
 continue a program flow use @escaping `AsyncReturn` parameter and name it
 `asyncReturn`.
 * You must call `asyncReturn`. Think of it as of mandatory return from
 a function.
 * If producing a value may fail, use `Failable` or `SpecificFailable` as
 `ReturnType`.
 
 Here is an example of definig and using such async return function.
 
 ````
 // Design function that returns awaited result asynchronously with parameter
 // with name `asyncReturn` and type `@escaping AsyncReturn`.
 func fetchWordOfTheDay(asyncReturn: @escaping AsyncReturn<Failable<String>>) {
     DispatchQueue.global().async(execute: { // Fake async.
         asyncReturn(Failable({ try wordOfTheDay() }))
         // or
         do {
             asyncReturn(.value(try wordOfTheDay()))
         } catch {
             asyncReturn(.failure(error))
         }
         // `asyncReturn` was called before program exits this scope.
     })
 }
 
 // just declaration for illustration
 func wordOfTheDay() throws -> String
 
 
 func printWordOfTheDay() {
     fetchWordOfTheDay(asyncReturn: { (wordOfTheDay) in
         // We feel safe to rely that this completion handler will be executed.
         do {
             print(try wordOfTheDay.unwrap())
         } catch {
             print(error)
         }
     })
 }
 ````
 
 - Todo: Check if Swift Lint could help with violation of the rules.
 
 - Requires: Follow the convention!
 
 - SeeAlso: `Failable` and `SpecificFailable`.
 */
public typealias AsyncReturn<ReturnType> = (ReturnType) -> Void
