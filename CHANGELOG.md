# Releases

1.2.0

* Add `#hash` ([PR #5](https://github.com/bellroy/sorbet-struct-comparable/pull/5))

1.1.0

* Fixed `T::Struct`'s of different classes returning `-1`; now returning `nil` as is expected of incomparable objects
* Fixed incomparable attributes of different returning `-1` instead of `nil`

1.0.0

* Initial release: Extracted from [https://bellroy.com/](Bellroy) projects.
