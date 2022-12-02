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

### Assume that the original author(s) have gone through all of the challenges, so you don't have to. 
### Assume they've gone through months of challenges, so you don't have to.

---

## So now what?

---

## Compaq: The first true clone.

---

## We'll clone the Obj-C

1. Write our standard to measure against.
2. Enable testing.
3. Create our clone, passing the same tests as the original.

---

## Ground rules

1. The original legacy class should not change.
2. We're not changing architecture (yet).
3. Add capabilities to the legacy class, allowing mocks.

---

## Mitigating risk

1. We can put the clone behind a feature flag.
2. We're wrapping the original's interface in tests.
3. Our clone should match that external behavior exactly.

---

# Demo