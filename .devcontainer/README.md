# GitHub Codespaces Configuration for DSAS 2025

This directory contains the configuration files for running the DSAS 2025 Module 1 Foundation Labs in GitHub Codespaces.

## 🎯 Overview

Students can run the complete Apache Spark learning environment in the cloud with one click, eliminating local setup requirements while providing a consistent, high-performance experience.

## 📁 Configuration Files

### `devcontainer.json`
Main configuration file that defines:
- **Base Image**: Universal Linux container with Java and Python
- **Resources**: 6GB RAM, 4 CPU cores for optimal Spark performance
- **Ports**: Auto-forward Jupyter (8888) and Spark UI (4040)
- **Extensions**: Python, Jupyter, Git integration
- **Environment**: Spark and Python configuration

### `setup.sh`
Installation script that:
- Downloads and configures Apache Spark 3.5.0
- Installs Python data science packages (pandas, matplotlib, etc.)
- Optimizes Spark configuration for Codespace constraints
- Sets up Jupyter Lab with proper networking
- Creates Spark logging configuration

### `startup.sh`
Workspace initialization script that:
- Ensures lab notebooks and datasets are accessible in Course Content directory
- Creates experiment template for students
- Starts Jupyter Lab automatically
- Validates Spark installation
- Displays helpful startup information

## 🚀 Usage for Students

### Getting Started
1. **One-Click Setup**: Go to repository → Code → Create Codespace
2. **Auto-Installation**: Wait 3-5 minutes for Spark environment setup
3. **Start Learning**: Jupyter Lab opens automatically with all labs ready
4. **Access Anywhere**: Resume from any browser, progress persists

### What Students Get
- **Apache Spark 3.5.0** - Latest stable version with optimizations
- **4-8GB RAM** - Sufficient for all course datasets and operations
- **Jupyter Lab** - Professional data science environment
- **All Course Materials** - 7 labs + datasets embedded and ready
- **Consistent Environment** - Identical setup for every student

### Student Workflow
```bash
# Codespace starts automatically, but if needed:
bash .devcontainer/startup.sh

# Access Jupyter Lab (auto-opens)
# http://localhost:8888

# Run validation
# Open: Environment-Check.ipynb

# Start learning
# Open: Course Content/Module 1 - Foundation/Lab Notebooks/Student Versions/Lab 1 - RDD Fundamentals.ipynb
```

## 🔧 Technical Details

### Resource Configuration
- **Memory**: 6GB total (3GB Spark driver + 2GB executor + 1GB system)
- **CPU**: 4 cores (2 driver + 2 executor)
- **Storage**: Persistent across Codespace sessions
- **Network**: Auto-forwarding for Jupyter and Spark UI

### Spark Optimization
```properties
# Adaptive Query Execution enabled
spark.sql.adaptive.enabled=true
spark.sql.adaptive.coalescePartitions.enabled=true

# Memory optimized for Codespace
spark.driver.memory=3g
spark.executor.memory=2g

# Arrow enabled for pandas integration
spark.sql.execution.arrow.pyspark.enabled=true
```

### Environment Variables
```bash
SPARK_HOME=/opt/spark
PYSPARK_PYTHON=/usr/local/python/current/bin/python
SPARK_OPTS="--driver-memory=3g --driver-cores=2 --executor-memory=2g"
```

## 🏫 Instructor Benefits

### Consistent Environment
- **Zero Setup Issues**: No "it works on my machine" problems
- **Identical Configuration**: Every student has exactly the same environment
- **Predictable Performance**: Reliable 4-core, 6GB setup for all
- **No Version Conflicts**: Controlled Spark 3.5.0 + Python 3.11 environment

### Teaching Advantages
- **Immediate Engagement**: Students start coding within 5 minutes
- **Focus on Learning**: Time spent on Spark concepts, not installation troubleshooting
- **Professional Tools**: GitHub integration teaches industry workflows
- **Remote Accessible**: Students can learn from anywhere with a browser

### Support Simplification
- **Direct Access**: Instructors can access student environments for debugging
- **Standardized Troubleshooting**: Known configuration eliminates variables
- **Cloud Resources**: No dependency on student hardware capabilities
- **Automatic Updates**: Environment improvements benefit all students immediately

## 🎓 Educational Impact

### Accessibility
- **Any Device**: Works on tablets, Chromebooks, low-end laptops
- **Global Access**: Students worldwide can access high-performance compute
- **Economic Inclusion**: No need for expensive hardware purchases
- **Reliable Internet**: Better than local Docker for unstable connections

### Learning Outcomes
- **Faster Start**: Students reach actual Spark learning within minutes
- **Professional Context**: GitHub Codespaces mirrors industry development environments
- **Version Control Integration**: Natural introduction to Git workflows
- **Cloud Computing**: Exposure to cloud-native development practices

## 🔍 Troubleshooting

### Common Issues

**Codespace Won't Start?**
- Check repository permissions and Codespace quotas
- Verify devcontainer.json syntax

**Spark Not Working?**
- Run `Environment-Check.ipynb` for diagnostics
- Check `/tmp/jupyter.log` for Jupyter issues
- Restart with `bash .devcontainer/startup.sh`

**Out of Memory?**
- Codespace automatically handles resource limits
- Spark configuration is optimized for 6GB total memory
- Use `.cache()` sparingly and `.unpersist()` when done

**Port Access Issues?**
- Codespace auto-forwards ports 8888 and 4040
- Check port forwarding in VS Code status bar
- Ensure Jupyter is running: `ps aux | grep jupyter`

### Performance Tips
- **Cache Strategically**: Only cache DataFrames you'll reuse multiple times
- **Monitor Memory**: Use Spark UI (port 4040) to track resource usage
- **Partition Appropriately**: Default settings work for course datasets
- **Stop Sessions**: Call `spark.stop()` when switching between labs

## 🚀 Advantages Over Local Docker

### For Students
| Aspect | Local Docker | GitHub Codespaces |
|--------|-------------|-------------------|
| **Setup Time** | 30-60 minutes | 3-5 minutes |
| **Hardware Requirements** | 8GB+ RAM recommended | Any device with browser |
| **Consistency** | Varies by system | Identical for everyone |
| **Performance** | Limited by local hardware | Guaranteed 4-core, 6GB |
| **Accessibility** | Requires Docker knowledge | Click and start |
| **Troubleshooting** | Student hardware variables | Standardized environment |

### For Instructors
| Aspect | Local Docker | GitHub Codespaces |
|--------|-------------|-------------------|
| **Support Burden** | High (setup issues) | Low (standardized env) |
| **Environment Control** | Limited | Complete |
| **Remote Help** | Difficult | Direct access possible |
| **Updates** | Manual for each student | Automatic for all |
| **Resource Guarantees** | None | Consistent performance |

## 📈 Scaling and Management

### Repository Management
- **Prebuilds**: Enable for faster student startup times
- **Resource Limits**: Configure org-wide Codespace policies
- **Cost Control**: Set timeout and resource limits appropriately
- **Access Control**: Manage who can create Codespaces

### Continuous Improvement
- **Monitor Usage**: Track which labs are most used/problematic
- **Gather Feedback**: Student experience data via Codespace insights
- **Update Environment**: Improve setup scripts based on usage patterns
- **Version Control**: Track environment changes like any other code

This Codespace configuration transforms the DSAS course from installation-dependent to universally accessible, ensuring every student can focus on learning Apache Spark rather than fighting with local environment setup.