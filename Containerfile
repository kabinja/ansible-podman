FROM docker.io/python:3.12 as build
WORKDIR /tmp
RUN pip install poetry
COPY ./pyproject.toml ./poetry.toml ./poetry.lock* /tmp/
RUN poetry install --no-root

FROM docker.io/python:3.12
WORKDIR /app
COPY --from=build /tmp/.venv /app/.venv
COPY ./app /app/app
COPY ./pyproject.toml /app/pyproject.toml
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]