# Design rationale

This document records what PPMF does differently and why, so others can evaluate,
reuse or extend the approach.

## The problem

Power Platform connections are per-user credentials. When one stops working, every app and
flow that depends on it starts failing, but:

- The platform reports connection health per connection, not per dependency.
- A flow uses a connection either directly (non-solution flows) or through a
  **connection reference** (solution flows), so there is no single place to look up
  "what uses this connection".
- Notifications, if any, go to the maker in the moment of failure, not to administrators,
  and not proactively before users notice.

Organizations typically learn about broken connections from end users, after business
processes have already failed.

## Approach

### 1. Dependency resolution across two storage models

PPMF joins three sources that are not normally combined:

1. **Connection status** from the Power Apps for Admins API (tenant-wide, per environment).
2. **Connection references** in each environment's Dataverse (`connectionreference.connectionid`).
3. **Flow definitions** in each environment's Dataverse (`workflow.clientdata`), searched for
   either the connection's name or the logical names of the references bound to it.

This gives an exact list of affected flows for both solution-aware and non-solution
flows, using only standard, supported APIs.

For canvas apps, whose metadata records connectors but not the run-time connection,
PPMF uses a transparent heuristic (same connector **and** same owner) and labels the result
as *likely affected*.

### 2. Owner-first notification

Instead of one admin report that someone must triage, PPMF groups findings by connection
owner and sends each owner only what they own, with a direct link to the page where it is
fixed. Administrators receive the full picture separately. This moves the fix to the
person who can actually re-authenticate the connection.

### 3. Admin-controlled scope

Every environment is discovered automatically, but monitoring is opt-out per environment
through a simple switch. Re-running discovery never overrides an administrator's choice.

### 4. Production-grade error handling in low code

All flows use nested Try/Catch scopes, per-environment isolation, soft-failure warnings,
bounded log fields and run deep links, so a monitoring tool does not itself become a
silent point of failure.

### 5. Packaged as one solution

Everything (tables, flows, app, connection references) ships as a single Dataverse
solution with no external hosting, so any tenant can install it with the standard
**Import solution** process.

## Relationship to existing tools

The Microsoft [CoE Starter Kit](https://learn.microsoft.com/power-platform/guidance/coe/core-components)
is a broad governance toolkit. Among many inventories, it records which **connectors** each
app and flow uses (its *CoE Connection Reference* table links connectors to apps and flows).

PPMF works at a different level and for a different goal:

| Question | Level PPMF answers it at |
|---|---|
| Which connections are broken right now? | Per **connection**, with its status and error, across enabled environments |
| Which flows will fail because of it? | Per **connection**: exact match through connection references and flow definitions |
| Which apps are likely to fail? | Same connector **and** same owner (heuristic, labeled as such) |
| Who must act, and how? | Each owner gets only their own list, with a direct fix link |
| Which environments are in scope? | Every discovered environment, with a per-environment opt-out |

PPMF is intended to sit alongside governance tooling such as the CoE Starter Kit, focusing
narrowly on operational health and fast remediation. It ships as one small solution with no
dependency on other toolkits.

## Known limitations

- App impact is a heuristic, because app metadata doesn't record the run-time connection.
- Flow resolution needs each environment's Dataverse to be reachable by the flow owner.
- Large tenants: the scan is sequential per environment to keep results consistent; very
  large tenants may want to split environments across multiple scheduled runs.
