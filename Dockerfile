FROM elixir:1.13.3-slim

WORKDIR /app

COPY . .

CMD ["elixir", "sort.exs"]