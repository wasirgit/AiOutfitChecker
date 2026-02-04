---
trigger: always_on
---

---
description: Standards for Swift and SwiftUI development to ensure clean, performant, and idiomatic code.
globs: ["**/*.swift"]
alwaysApply: true
---

# iOS / Swift / SwiftUI Rules

## Core Principles
- **Keep it Simple:** Favor native SwiftUI solutions over custom complex architectures. Use `@State`, `@Binding`, and `@Environment` where appropriate.
- **No Overengineering:** Do not implement "Clean Architecture" or "VIPER" unless explicitly requested. Start with a simple MVVM or MV pattern.
- **Project Structure:**
  - `Views/`: SwiftUI View files.
  - `ViewModels/`: Logic for views (if needed).
  - `Models/`: Data structures.
  - `Resources/`: Assets and localizations.

## SwiftUI Coding Standards
- **View Composition:** Break large views into smaller, reusable private computed properties or sub-views.
- **Performance:** Use `LazyVStack` and `LazyHStack` for long lists. Avoid heavy computations inside the `body` property.
- **Modifiers:** Order modifiers logically (layout first, then styling).
- **Previews:** Always provide a `PreviewProvider` or `#Preview` macro with mock data.

## Swift Coding Standards
- **Concurrency:** Use `async/await` and `Task` instead of completion handlers.
- **Access Control:** Default to `private` or `internal`. Use `final class` for ViewModels to improve dispatch performance.
- **Safety:** Avoid force unwrapping (`!`). Use `if let` or `guard let`.
- **Naming:** Follow Swift API Design Guidelines (e.g., `isEditing` for Booleans, verbs for methods).

## Prohibited
- DO NOT create any `.md` or documentation files unless specifically asked.
- DO NOT add external dependencies (CocoaPods/SPM) without permission.
- DO NOT use Combine for simple state management where `@Published` and `Observable` suffice.