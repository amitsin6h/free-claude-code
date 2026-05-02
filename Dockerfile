FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy repo
COPY . .

# Install Python 3.14 (required by repo)
RUN uv python install 3.14

# Install dependencies
RUN uv sync

# Expose port
EXPOSE 8082

# Start server
CMD ["uv", "run", "uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8082"]
