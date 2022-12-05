# ObjC to Swift
## A sane way to migrate

---

## Infinite possibilities

### You can't know everything about this code.

- You don't know what was in the author's head.
- You don't know the original constraints.
- You don't know the original requirements.
- You don't know what APIs were not available then.
- You don't know the time crunch they were under.

---

## Assume good intent

### Assume that the original author(s) have gone through all of the challenges, the bug fixes, and the frustrations, so you don't have to.

---

## So how can we migrate this code?

---

## Option 1: I'm an awesome coder, and great at Swift. What could go wrong? Just rewrite each class. No need to test the old code.

### Outcome: Bugs bugs bugs, for months on and on.

---

## Option 2: Replace portions of the app in sections. Entire rewrites of clusters of classes.

### Outcome: Months of planning. Grueling and expensive.

---

## There's a better way.

---

## Historical example: Compaq, The first true IBM clone.

---

## We'll clone the Obj-C

1. Implement top-to-bottom testing of the legacy code.
2. Create our clone, duplicating the same tests as the original.
3. Line-by-line copy, at first.

---

## Ground rules

1. The original legacy class _should not change_ more than is needed for compatibility with Swift!
2. We're _not changing architecture_ (yet).
3. Add interfaces and conformance to the legacy class to allow for mocking.
4. No refactoring beyond this (yet).

---

## Mitigating risk

1. We can put the clone behind a feature flag.
2. We're wrapping the original's interface in tests.
3. Our clone should match that external behavior exactly.
4. We can truthfully answer the questions "Has the old code been changed, and can we roll back to the old code in production if this goes wrong?"

---

## Goals

1. Make the product team confident in your changes. Instill confidence in them when you push future changes.
2. Make your teammates confident in your changes. Make it easier to trust your changes.
3. Avoid problematic releases and minimize impact. Product knows that if issues arise, they can switch off a Split treatment. No hot fix needed. (Or they can roll it out slowly.)
4. Sleep well at night and relax on weekends.

---

# Demo