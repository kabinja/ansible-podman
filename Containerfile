FROM docker.io/python:3.12-slim-bookworm  as base

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

FROM base AS builder

ENV POETRY_VERSION=1.8.3 

RUN pip install "poetry==$POETRY_VERSION"
COPY ./pyproject.toml ./poetry.toml ./poetry.lock* ./
RUN poetry install --no-root

COPY . .
RUN poetry build

FROM base AS final

ENV PATH="/app/.venv/bin:$PATH"

COPY --from=builder /app/.venv ./.venv
COPY --from=builder /app/dist ./dist
COPY ./pyproject.toml ./pyproject.toml

RUN pip install ./dist/*.whl

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]