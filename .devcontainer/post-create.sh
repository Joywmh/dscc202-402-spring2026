#!/bin/bash

# DSAS 2025 - Post-Create Setup Script
# Sets up UV virtual environment and installs project dependencies

set -e  # Exit on any error

echo "🔧 DSAS 2025 - Setting up UV virtual environment"
echo "================================================"

# Install UV (Python package manager)
echo "📦 Installing UV package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"

# Verify UV installation
echo "✅ UV installed: $(uv --version)"

# Navigate to project root
cd /workspaces/data_science_at_scale

# Install project dependencies using UV
echo "🐍 Installing project dependencies with UV..."
uv sync

# Verify critical packages are installed in the virtual environment
echo "🔍 Verifying virtual environment setup..."
VENV_PYTHON="/workspaces/data_science_at_scale/.venv/bin/python3"

if [ -f "$VENV_PYTHON" ]; then
    echo "✅ Virtual environment Python found: $VENV_PYTHON"

    # Test critical packages
    $VENV_PYTHON -c "import pandas; print(f'✅ pandas {pandas.__version__} available in venv')" || {
        echo "❌ pandas not available in virtual environment"
        exit 1
    }

    $VENV_PYTHON -c "import pyspark; print(f'✅ pyspark {pyspark.__version__} available in venv')" || {
        echo "❌ pyspark not available in virtual environment"
        exit 1
    }

    $VENV_PYTHON -c "import pyarrow; print(f'✅ pyarrow {pyarrow.__version__} available in venv')" || {
        echo "❌ pyarrow not available in virtual environment"
        exit 1
    }

else
    echo "❌ Virtual environment not created properly"
    exit 1
fi

# Update environment variables in .bashrc for the vscode user
echo "🌐 Updating environment variables for virtual environment..."
cat >> ~/.bashrc << 'EOF'

# DSAS 2025 - UV Virtual Environment Configuration
export PYSPARK_PYTHON=/workspaces/data_science_at_scale/.venv/bin/python3
export PYSPARK_DRIVER_PYTHON=/workspaces/data_science_at_scale/.venv/bin/python3

# Add UV to PATH
export PATH="$HOME/.cargo/bin:$PATH"
EOF

# Create a convenience script for activating the virtual environment
cat > /workspaces/data_science_at_scale/activate_venv.sh << 'EOF'
#!/bin/bash
# Convenience script to activate the UV virtual environment
source /workspaces/data_science_at_scale/.venv/bin/activate
echo "✅ Virtual environment activated"
echo "🐍 Python: $(which python3)"
echo "📦 Packages:"
pip list | grep -E "(pandas|pyspark|pyarrow)" || echo "No packages found"
EOF

chmod +x /workspaces/data_science_at_scale/activate_venv.sh

echo ""
echo "✅ UV Virtual Environment Setup Complete!"
echo "========================================"
echo ""
echo "🎯 Environment Details:"
echo "   • UV Virtual Environment: /workspaces/data_science_at_scale/.venv/"
echo "   • Python: $VENV_PYTHON"
echo "   • PYSPARK_PYTHON: /workspaces/data_science_at_scale/.venv/bin/python3"
echo "   • Activation script: ./activate_venv.sh"
echo ""
echo "📚 Ready for Spark with pandas UDF support!"
echo ""