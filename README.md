# spark-hadoop-winutils
Hadoop winutils dependencies for Spark on Windows.
The main reason for this repository is to enable the usage of [Spark](https://spark.apache.org/downloads.html) on Windows.
This was/is necessary, because of the lack of the winutils in official donwloads.

## Build-Requirements
 - JDK (tested with Adoptium JDK 11)
 - Git
 - Powershell
 - Visual Studio (Community is enough - tested with 2022)

## Build
Run Build-Hadoop and follow instructions.

    > powershell
    . Build-Hadoop.ps
    Build-Hadoop -Version 3.3.2

You may need to set preprocessor variables:

    WSCE_CONFIG_DIR="../etc/hadoop"
    WSCE_CONFIG_FILE="wsce-site.xml"

The exact values can be extracted from projects `pom.xml`.

## Installation
Download a release matching the bundled Hadoop version ([Winutils](https://github.com/brunothg/spark-hadoop-winutils/tree/winutils) or [Releases](https://github.com/brunothg/spark-hadoop-winutils/releases)).
The Hadoop version Spark comes with can be found in the included `RELEASE` file.
Then place the downloaded `hadoop` folder (must contain the bin folder) on your local drive and set the `HADOOP_HOME` environment variable acordingly.

## Notice
I build these in my free time and for my own purposes.
So feel free to use them for your purposes, but i cannot guarantee anything or give any support.

## Alternatives

For other winutils builds have a look at this repositories:
 * [cdarlint/winutils](https://github.com/cdarlint/winutils)
 * [steveloughran/winutils](https://github.com/steveloughran/winutils)
 * [kontext-tech/winutils](https://github.com/kontext-tech/winutils)

Maybe on of this pure Java replacements is an option for you:
 * [globalmentor/hadoop-bare-naked-local-fs](https://github.com/globalmentor/hadoop-bare-naked-local-fs)
 * [SebVentures/seed-spark](https://github.com/SebVentures/seed-spark)
