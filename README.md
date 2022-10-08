[--no-snapshot-update option does not prevent metadata.xml download](https://issues.apache.org/jira/browse/MRESOLVER-277)


The issue is triggered by the following conditions:

- `maven-enforcer-plugin` with `requireUpperBoundDeps` rule enabled
- at least one custom snapshots repository declared
- no negative cache entry for the project modules in the local repository

All of these conditions are set in branch master.

To reproduce, run:

```bash
./reproduce.sh
```

**or**

```bash
rm -fr ~/.m2/repository/me/redaalaoui/mresolver_277 && mvn clean package
```

## What happens

Maven prints:

```
[INFO] ------------------< me.redaalaoui.mresolver_277:core >------------------
[INFO] Building core 1-SNAPSHOT                                           [2/3]
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- maven-clean-plugin:2.5:clean (default-clean) @ core ---
[INFO] Deleting /home/rhousni/projects/mresolver-277/core/target
[INFO]
[INFO] --- maven-enforcer-plugin:3.0.0:enforce (enforce) @ core ---
Downloading from spring-snapshot: https://repo.spring.io/snapshot/me/redaalaoui/mresolver_277/core/1-SNAPSHOT/maven-metadata.xml
```

i.e. A request is made to `https://repo.spring.io/snapshot` for each project's module.

## What was expected

No request made to `https://repo.spring.io/snapshot`.

## Additional comments

Using `-nsu,--no-snapshot-updates Suppress SNAPSHOT updates` does not fix the issue.
