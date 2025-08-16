# Use a small official Python base image
FROM python:3.11-slim

# Safety: don’t run as root in the final image
# (We’ll create a non-root user)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install only security updates and minimal tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*

# Copy dependency file first (better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Now copy app code
COPY app.py .

# Create a non-root user and switch to it
RUN useradd -m appuser
USER appuser

# Expose the app port
EXPOSE 5000

# Default command
CMD ["python", "app.py"]
